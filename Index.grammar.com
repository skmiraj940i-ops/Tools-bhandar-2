<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Free online grammar checker - Instantly find and fix grammar mistakes in your text with AI-powered suggestions">
    <meta name="keywords" content="grammar checker, grammar correction, writing assistant, proofreading">
    <title>GrammarCheck Pro - Free Online Grammar Checker Tool</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4361ee;
            --primary-dark: #3a56d4;
            --secondary: #7209b7;
            --light: #f8f9fa;
            --dark: #212529;
            --success: #4cc9f0;
            --warning: #f72585;
            --error: #e63946;
            --gray: #6c757d;
            --border-radius: 8px;
            --box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f5f7fb;
            color: var(--dark);
            line-height: 1.6;
        }

        .container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        header {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            padding: 2rem 0;
            text-align: center;
            margin-bottom: 2rem;
            box-shadow: var(--box-shadow);
        }

        h1 {
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
        }

        .tagline {
            font-size: 1.1rem;
            opacity: 0.9;
        }

        main {
            display: grid;
            grid-template-columns: 1fr;
            gap: 2rem;
            margin-bottom: 2rem;
        }

        @media (min-width: 992px) {
            main {
                grid-template-columns: 1fr 300px;
            }
        }

        .tool-section {
            background: white;
            border-radius: var(--border-radius);
            padding: 2rem;
            box-shadow: var(--box-shadow);
        }

        .input-area {
            margin-bottom: 2rem;
        }

        .text-input {
            width: 100%;
            min-height: 250px;
            padding: 1rem;
            border: 1px solid #ddd;
            border-radius: var(--border-radius);
            resize: vertical;
            font-size: 1rem;
            margin-bottom: 1rem;
            transition: var(--transition);
            line-height: 1.6;
        }

        .text-input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 2px rgba(67, 97, 238, 0.2);
        }

        .controls {
            display: flex;
            flex-direction: column;
            gap: 1rem;
            margin-bottom: 2rem;
        }

        @media (min-width: 768px) {
            .controls {
                flex-direction: row;
                align-items: center;
            }
        }

        .btn {
            background-color: var(--primary);
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: var(--border-radius);
            cursor: pointer;
            font-weight: 600;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
        }

        .btn:disabled {
            background-color: var(--gray);
            cursor: not-allowed;
            transform: none;
        }

        .btn-secondary {
            background-color: #6c757d;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
        }

        .btn-success {
            background-color: var(--success);
        }

        .btn-success:hover {
            background-color: #3ab0d9;
        }

        .stats {
            display: flex;
            gap: 1rem;
            margin-bottom: 1.5rem;
            flex-wrap: wrap;
        }

        .stat-item {
            background: #e8f4fd;
            padding: 0.75rem;
            border-radius: var(--border-radius);
            text-align: center;
            flex: 1;
            min-width: 120px;
        }

        .stat-value {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary);
        }

        .stat-label {
            font-size: 0.85rem;
            color: var(--gray);
        }

        .output-area {
            margin-top: 2rem;
        }

        .output-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .output-title {
            font-size: 1.25rem;
            font-weight: 600;
        }

        .output-container {
            border: 1px solid #ddd;
            border-radius: var(--border-radius);
            padding: 1.5rem;
            background: #f8f9fa;
            min-height: 200px;
            position: relative;
        }

        .output-text {
            line-height: 1.7;
        }

        .error-highlight {
            background-color: rgba(230, 57, 70, 0.15);
            border-bottom: 2px dashed var(--error);
            cursor: pointer;
            position: relative;
        }

        .error-highlight:hover::after {
            content: "Click for suggestions";
            position: absolute;
            bottom: -25px;
            left: 0;
            background: var(--dark);
            color: white;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.75rem;
            white-space: nowrap;
            z-index: 10;
        }

        .suggestions-panel {
            margin-top: 1.5rem;
            padding: 1rem;
            background: white;
            border-radius: var(--border-radius);
            border: 1px solid #e9ecef;
            display: none;
        }

        .suggestions-panel.active {
            display: block;
        }

        .suggestion-item {
            padding: 0.75rem;
            border-bottom: 1px solid #e9ecef;
            cursor: pointer;
            transition: var(--transition);
        }

        .suggestion-item:last-child {
            border-bottom: none;
        }

        .suggestion-item:hover {
            background: #f8f9fa;
        }

        .suggestion-correct {
            color: var(--success);
            font-weight: 600;
        }

        .suggestion-explanation {
            font-size: 0.9rem;
            color: var(--gray);
            margin-top: 0.25rem;
        }

        .loading {
            display: none;
            text-align: center;
            margin: 1rem 0;
        }

        .loading.active {
            display: block;
        }

        .spinner {
            border: 4px solid rgba(0, 0, 0, 0.1);
            border-left-color: var(--primary);
            border-radius: 50%;
            width: 40px;
            height: 40px;
            animation: spin 1s linear infinite;
            margin: 0 auto;
        }

        @keyframes spin {
            to {
                transform: rotate(360deg);
            }
        }

        .sidebar {
            display: flex;
            flex-direction: column;
            gap: 2rem;
        }

        .ad-container {
            background: white;
            border-radius: var(--border-radius);
            padding: 1rem;
            box-shadow: var(--box-shadow);
            text-align: center;
            min-height: 250px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
        }

        .ad-label {
            font-size: 0.8rem;
            color: var(--gray);
            margin-bottom: 0.5rem;
        }

        .ad-placeholder {
            width: 100%;
            height: 200px;
            background-color: #f8f9fa;
            border: 1px dashed #dee2e6;
            border-radius: var(--border-radius);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--gray);
            flex-direction: column;
            gap: 0.5rem;
        }

        .info-box {
            background: white;
            border-radius: var(--border-radius);
            padding: 1.5rem;
            box-shadow: var(--box-shadow);
        }

        .info-box h3 {
            margin-bottom: 1rem;
            color: var(--primary);
        }

        .info-box ul {
            padding-left: 1.5rem;
        }

        .info-box li {
            margin-bottom: 0.5rem;
        }

        footer {
            background-color: var(--dark);
            color: white;
            padding: 2rem 0;
            text-align: center;
            margin-top: 3rem;
        }

        .footer-content {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        @media (min-width: 768px) {
            .footer-content {
                flex-direction: row;
                justify-content: space-between;
                align-items: center;
            }
        }

        .footer-links {
            display: flex;
            gap: 1.5rem;
            justify-content: center;
        }

        .footer-links a {
            color: white;
            text-decoration: none;
            transition: var(--transition);
        }

        .footer-links a:hover {
            color: var(--success);
        }

        .sample-texts {
            margin-top: 2rem;
        }

        .sample-texts h3 {
            margin-bottom: 1rem;
            color: var(--primary);
        }

        .sample-btns {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }

        .sample-btn {
            padding: 0.5rem 1rem;
            background: #e9ecef;
            border: none;
            border-radius: var(--border-radius);
            cursor: pointer;
            transition: var(--transition);
            font-size: 0.9rem;
        }

        .sample-btn:hover {
            background: #dee2e6;
        }

        .word-count {
            position: absolute;
            bottom: 10px;
            right: 15px;
            font-size: 0.85rem;
            color: var(--gray);
        }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <h1><i class="fas fa-spell-check"></i> GrammarCheck Pro</h1>
            <p class="tagline">Instantly find and fix grammar mistakes in your text with AI-powered suggestions</p>
        </div>
    </header>

    <div class="container">
        <main>
            <div class="tool-section">
                <div class="input-area">
                    <h2>Check Your Text</h2>
                    <textarea class="text-input" id="textInput" placeholder="Paste or type your text here... (Minimum 50 characters for best results)"></textarea>
                    
                    <div class="controls">
                        <button class="btn" id="checkBtn">
                            <i class="fas fa-search"></i> Check Grammar
                        </button>
                        
                        <button class="btn btn-secondary" id="clearBtn">
                            <i class="fas fa-broom"></i> Clear Text
                        </button>

                        <button class="btn btn-success" id="applyAllBtn" disabled>
                            <i class="fas fa-check-double"></i> Apply All Corrections
                        </button>
                    </div>
                </div>

                <div class="stats">
                    <div class="stat-item">
                        <div class="stat-value" id="wordCount">0</div>
                        <div class="stat-label">Words</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-value" id="errorCount">0</div>
                        <div class="stat-label">Errors Found</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-value" id="charCount">0</div>
                        <div class="stat-label">Characters</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-value" id="readTime">0 min</div>
                        <div class="stat-label">Reading Time</div>
                    </div>
                </div>

                <div class="loading" id="loadingIndicator">
                    <div class="spinner"></div>
                    <p>AI is analyzing your text for grammar mistakes...</p>
                </div>

                <div class="output-area">
                    <div class="output-header">
                        <h3 class="output-title">Checked Text</h3>
                        <button class="btn" id="copyBtn" disabled>
                            <i class="far fa-copy"></i> Copy Corrected Text
                        </button>
                    </div>
                    <div class="output-container">
                        <div class="output-text" id="outputText">
                            Your checked text with highlighted errors will appear here...
                        </div>
                        <div class="word-count" id="outputWordCount">0 words</div>
                    </div>

                    <div class="suggestions-panel" id="suggestionsPanel">
                        <h4>Suggestions for: <span id="errorText"></span></h4>
                        <div id="suggestionsList">
                            <!-- Suggestions will be populated here -->
                        </div>
                    </div>
                </div>

                <div class="sample-texts">
                    <h3>Try with Sample Text</h3>
                    <div class="sample-btns">
                        <button class="sample-btn" data-sample="essay">Student Essay</button>
                        <button class="sample-btn" data-sample="business">Business Email</button>
                        <button class="sample-btn" data-sample="blog">Blog Post</button>
                        <button class="sample-btn" data-sample="casual">Casual Text</button>
                    </div>
                </div>
            </div>

            <div class="sidebar">
                <div class="ad-container">
                    <div class="ad-label">Advertisement</div>
                    <div class="ad-placeholder">
                        <i class="fas fa-ad fa-2x"></i>
                        <p>Ad Space</p>
                        <!-- Google AdSense Ad Unit -->
                        <!-- Replace with your Ad Unit ID -->
                        <script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-XXXXXXXXXXXXXXXX"
                                crossorigin="anonymous"></script>
                        <ins class="adsbygoogle"
                             style="display:block"
                             data-ad-client="ca-pub-XXXXXXXXXXXXXXXX"
                             data-ad-slot="XXXXXXXXXX"
                             data-ad-format="auto"
                             data-full-width-responsive="true"></ins>
                        <script>
                             (adsbygoogle = window.adsbygoogle || []).push({});
                        </script>
                    </div>
                </div>

                <div class="info-box">
                    <h3>How It Works</h3>
                    <ul>
                        <li>Paste or type your text in the input area</li>
                        <li>Click "Check Grammar" to analyze</li>
                        <li>Click highlighted errors to see suggestions</li>
                        <li>Apply corrections individually or all at once</li>
                        <li>Copy the corrected text</li>
                    </ul>
                </div>

                <div class="info-box">
                    <h3>Common Grammar Issues Detected</h3>
                    <ul>
                        <li>Spelling mistakes</li>
                        <li>Punctuation errors</li>
                        <li>Subject-verb agreement</li>
                        <li>Verb tense consistency</li>
                        <li>Sentence fragments</li>
                        <li>Wrong word usage</li>
                    </ul>
                </div>

                <div class="ad-container">
                    <div class="ad-label">Advertisement</div>
                    <div class="ad-placeholder">
                        <i class="fas fa-ad fa-2x"></i>
                        <p>Ad Space</p>
                        <!-- Second Google AdSense Ad Unit -->
                        <!-- Replace with your Ad Unit ID -->
                        <script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-XXXXXXXXXXXXXXXX"
                                crossorigin="anonymous"></script>
                        <ins class="adsbygoogle"
                             style="display:block"
                             data-ad-client="ca-pub-XXXXXXXXXXXXXXXX"
                             data-ad-slot="XXXXXXXXXX"
                             data-ad-format="auto"
                             data-full-width-responsive="true"></ins>
                        <script>
                             (adsbygoogle = window.adsbygoogle || []).push({});
                        </script>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <footer>
        <div class="container">
            <div class="footer-content">
                <div class="copyright">
                    <p>&copy; 2023 GrammarCheck Pro. All rights reserved.</p>
                </div>
                <div class="footer-links">
                    <a href="#">Privacy Policy</a>
                    <a href="#">Terms of Service</a>
                    <a href="#">Contact Us</a>
                </div>
            </div>
        </div>
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // DOM Elements
            const textInput = document.getElementById('textInput');
            const checkBtn = document.getElementById('checkBtn');
            const clearBtn = document.getElementById('clearBtn');
            const applyAllBtn = document.getElementById('applyAllBtn');
            const copyBtn = document.getElementById('copyBtn');
            const outputText = document.getElementById('outputText');
            const loadingIndicator = document.getElementById('loadingIndicator');
            const sampleBtns = document.querySelectorAll('.sample-btn');
            const suggestionsPanel = document.getElementById('suggestionsPanel');
            const errorText = document.getElementById('errorText');
            const suggestionsList = document.getElementById('suggestionsList');
            const wordCount = document.getElementById('wordCount');
            const errorCount = document.getElementById('errorCount');
            const charCount = document.getElementById('charCount');
            const readTime = document.getElementById('readTime');
            const outputWordCount = document.getElementById('outputWordCount');

            // Variables
            let currentErrors = [];
            let currentText = '';
            let corre
