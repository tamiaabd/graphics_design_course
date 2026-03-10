import 'package:flutter/material.dart';

class Lesson {
  final String title;
  final String content;
  final List<String>? bulletPoints;
  final List<String>? examples;

  Lesson({
    required this.title,
    required this.content,
    this.bulletPoints,
    this.examples,
  });
}

class Module {
  final int number;
  final String title;
  final List<Lesson> lessons;
  final String icon;
  final Color color;

  Module({
    required this.number,
    required this.title,
    required this.lessons,
    required this.icon,
    required this.color,
  });
}

class Course {
  final String title;
  final String description;
  final String duration;
  final int totalModules;
  final List<String> learningOutcomes;
  final List<Module> modules;
  final String finalMessage;

  Course({
    required this.title,
    required this.description,
    required this.duration,
    required this.totalModules,
    required this.learningOutcomes,
    required this.modules,
    required this.finalMessage,
  });

  /// Cached total lesson count to avoid repeated fold() in build methods.
  int get totalLessons =>
      modules.fold(0, (sum, m) => sum + m.lessons.length);
}

// Course Data
final Course graphicDesignCourse = Course(
  title: 'GRAPHIC DESIGN MASTER CURRICULUM',
  description: 'Graphic design is the art of visual communication. It involves using images, text, colors, shapes, and layouts to communicate ideas and messages effectively.',
  duration: '4–6 Months',
  totalModules: 15,
  learningOutcomes: [
    'Design fundamentals',
    'Professional design tools',
    'Color theory',
    'Typography',
    'Branding design',
    'Social media graphics',
    'UI design basics',
    'Portfolio building',
    'Freelancing skills',
  ],
  finalMessage: 'Graphic design is a skill that improves with practice. Study good designs. Practice regularly. Build a strong portfolio. With dedication and creativity, graphic design can become a successful career.',
  modules: [
    Module(
      number: 1,
      title: 'INTRODUCTION TO GRAPHIC DESIGN',
      icon: '🎨',
      color: const Color(0xFF6366F1),
      lessons: [
        Lesson(
          title: 'What is Graphic Design',
          content: 'Graphic design is the practice of communicating ideas visually.',
          bulletPoints: [
            'Text',
            'Images',
            'Shapes',
            'Colors',
            'Layouts',
          ],
          examples: [
            'Logos',
            'Posters',
            'Social media posts',
            'Advertisements',
            'Websites',
            'Mobile applications',
            'Product packaging',
          ],
        ),
        Lesson(
          title: 'Why Graphic Design is Important',
          content: 'Graphic design is essential for businesses and communication. Companies use graphic design to attract customers, build brand identity, explain products, and promote services.',
        ),
        Lesson(
          title: 'Types of Graphic Design',
          content: 'Graphic design has many specializations.',
          bulletPoints: [
            'Branding Design - Designing logos and brand identities',
            'Marketing Design - Creating advertisements, banners, and promotional graphics',
            'UI Design - Designing interfaces for mobile apps and websites',
            'Print Design - Designing magazines, brochures, flyers, and posters',
            'Packaging Design - Designing product boxes and labels',
            'Motion Graphics - Animated graphics used in videos and presentations',
          ],
        ),
      ],
    ),
    Module(
      number: 2,
      title: 'DESIGN SOFTWARE',
      icon: '💻',
      color: const Color(0xFF8B5CF6),
      lessons: [
        Lesson(
          title: 'Raster vs Vector Graphics',
          content: 'There are two main types of graphics.',
          bulletPoints: [
            'Raster Graphics - Made of pixels. Examples: JPG, PNG, Photos. Used for photo editing and detailed images.',
            'Vector Graphics - Made from mathematical paths. Can be resized without losing quality. Used for logos, icons, and illustrations.',
          ],
        ),
        Lesson(
          title: 'Professional Design Tools',
          content: 'Common tools used by designers include:',
          bulletPoints: [
            'Photoshop - Used for photo editing and digital graphics',
            'Illustrator - Used for vector graphics such as logos and icons',
            'Figma - Used for website and app interface design',
            'After Effects - Used for motion graphics and animation',
          ],
        ),
      ],
    ),
    Module(
      number: 3,
      title: 'DESIGN FUNDAMENTALS',
      icon: '✨',
      color: const Color(0xFFEC4899),
      lessons: [
        Lesson(
          title: 'Elements of Design',
          content: 'All visual designs are built using basic elements. These fundamental building blocks work together to create effective visual communication.',
          bulletPoints: [
            'Line - Connects points and guides the eye',
            'Shape - Two-dimensional forms (circles, squares, triangles)',
            'Color - Adds emotion and meaning to designs',
            'Texture - Creates visual and tactile interest',
            'Space - The area around and between elements',
            'Form - Three-dimensional shapes with depth',
          ],
        ),
        Lesson(
          title: 'Lines in Design',
          content: 'Lines guide the viewer\'s eye and create movement in a design. Different lines communicate different emotions and messages.',
          bulletPoints: [
            'Straight lines represent order and stability',
            'Curved lines represent softness and elegance',
            'Zigzag lines represent energy and excitement',
            'Horizontal lines suggest calm and stability',
            'Vertical lines suggest strength and growth',
            'Diagonal lines suggest movement and action',
          ],
        ),
        Lesson(
          title: 'Shapes and Forms',
          content: 'Shapes are the foundation of visual design. They can be geometric or organic, and each type conveys different meanings.',
          bulletPoints: [
            'Geometric shapes - Circles, squares, triangles (order, structure)',
            'Organic shapes - Natural, flowing forms (creativity, freedom)',
            'Abstract shapes - Simplified representations of real objects',
            'Positive shapes - The main subject or element',
            'Negative shapes - The space around the subject',
          ],
        ),
        Lesson(
          title: 'Texture in Design',
          content: 'Texture adds depth and interest to designs. It can be visual (implied) or tactile (actual).',
          bulletPoints: [
            'Visual texture - Created through patterns and shading',
            'Tactile texture - Physical surface quality',
            'Smooth textures - Modern, clean, professional',
            'Rough textures - Natural, organic, handmade',
            'Texture creates contrast and visual interest',
          ],
        ),
        Lesson(
          title: 'Space and Composition',
          content: 'Space is the area around, between, and within design elements. Effective use of space is crucial for good design.',
          bulletPoints: [
            'Positive space - The main subject or elements',
            'Negative space (white space) - Empty areas that give breathing room',
            'Active space - Areas with visual elements',
            'Passive space - Empty areas that support the design',
            'Proper spacing improves readability and visual hierarchy',
          ],
        ),
      ],
    ),
    Module(
      number: 4,
      title: 'PRINCIPLES OF DESIGN',
      icon: '⚖️',
      color: const Color(0xFFF59E0B),
      lessons: [
        Lesson(
          title: 'Balance',
          content: 'Balance refers to equal visual weight in a design. It creates stability and harmony.',
          bulletPoints: [
            'Symmetrical balance - Both sides look similar (formal, stable)',
            'Asymmetrical balance - Different elements still feel balanced (dynamic, interesting)',
            'Radial balance - Elements spread around a center point (circular, focused)',
            'Visual weight - How much attention an element draws',
            'Balance creates professional, polished designs',
          ],
        ),
        Lesson(
          title: 'Contrast',
          content: 'Contrast helps important elements stand out and creates visual interest. It guides the viewer\'s attention.',
          bulletPoints: [
            'Light vs dark - Value contrast',
            'Large vs small - Size contrast',
            'Bold vs thin - Weight contrast',
            'Bright vs dull colors - Color contrast',
            'Contrast improves readability and hierarchy',
          ],
        ),
        Lesson(
          title: 'Emphasis and Hierarchy',
          content: 'Emphasis makes certain elements stand out. Visual hierarchy guides the viewer through the design in order of importance.',
          bulletPoints: [
            'Emphasis - Making key elements prominent',
            'Hierarchy - Organizing information by importance',
            'Size - Larger elements draw more attention',
            'Color - Bright colors stand out',
            'Position - Center and top positions are most noticed',
            'Typography - Bold, large fonts create emphasis',
          ],
        ),
        Lesson(
          title: 'Rhythm and Repetition',
          content: 'Rhythm creates movement and flow. Repetition creates consistency and unity.',
          bulletPoints: [
            'Repetition - Using similar elements throughout',
            'Pattern - Repeating visual elements',
            'Rhythm - Visual flow and movement',
            'Consistency - Using repeated elements creates brand identity',
            'Variation - Slight changes in repetition add interest',
          ],
        ),
        Lesson(
          title: 'Proportion and Scale',
          content: 'Proportion is the relationship between elements. Scale refers to the size of elements relative to each other.',
          bulletPoints: [
            'Proportion - Size relationships between elements',
            'Scale - Relative size of elements',
            'Golden ratio - Aesthetic proportion (1:1.618)',
            'Rule of thirds - Dividing space into thirds',
            'Proper proportion creates harmony',
          ],
        ),
        Lesson(
          title: 'Unity and Harmony',
          content: 'Unity brings all elements together. Harmony creates a cohesive, pleasing design.',
          bulletPoints: [
            'Unity - All elements work together',
            'Harmony - Elements complement each other',
            'Consistency - Using similar styles and colors',
            'Cohesion - Elements feel connected',
            'Unity creates professional, polished designs',
          ],
        ),
      ],
    ),
    Module(
      number: 5,
      title: 'TYPOGRAPHY',
      icon: '📝',
      color: const Color(0xFF10B981),
      lessons: [
        Lesson(
          title: 'Typography Basics',
          content: 'Typography is the art of arranging text to make it readable, legible, and visually appealing.',
          bulletPoints: [
            'Font choice - Selecting appropriate typefaces',
            'Font size - Determining text size for readability',
            'Line spacing (leading) - Space between lines',
            'Letter spacing (tracking) - Space between letters',
            'Alignment - Left, right, center, or justified',
          ],
        ),
        Lesson(
          title: 'Typeface Categories',
          content: 'Understanding different typeface categories helps you choose the right font for your design.',
          bulletPoints: [
            'Serif - Traditional, formal (Times New Roman, Georgia)',
            'Sans-serif - Modern, clean (Helvetica, Arial)',
            'Script - Elegant, decorative (Brush Script)',
            'Display - Bold, attention-grabbing (Impact)',
            'Monospace - Fixed width (Courier, Monaco)',
          ],
        ),
        Lesson(
          title: 'Font Pairing',
          content: 'Combining fonts effectively creates visual hierarchy and interest. Good font pairing enhances readability.',
          bulletPoints: [
            'Pair serif with sans-serif for contrast',
            'Limit to 2-3 fonts per design',
            'Use different weights (bold, regular, light)',
            'Ensure fonts complement each other',
            'Test readability at different sizes',
          ],
        ),
        Lesson(
          title: 'Typography Hierarchy',
          content: 'Typography hierarchy guides readers through content by establishing importance levels.',
          bulletPoints: [
            'Headings - Largest, most prominent text',
            'Subheadings - Medium size, secondary importance',
            'Body text - Standard size for main content',
            'Captions - Smallest text for additional info',
            'Use size, weight, and color to create hierarchy',
          ],
        ),
        Lesson(
          title: 'Readability vs Legibility',
          content: 'Readability and legibility are different but equally important aspects of typography.',
          bulletPoints: [
            'Legibility - Can you distinguish individual letters?',
            'Readability - Can you easily read blocks of text?',
            'Font size affects both',
            'Line length impacts readability (45-75 characters ideal)',
            'Line spacing improves readability',
          ],
        ),
        Lesson(
          title: 'Typography in Different Media',
          content: 'Typography requirements vary across different media. Understanding these differences is crucial.',
          bulletPoints: [
            'Print - Higher resolution, more font options',
            'Web - Limited fonts, consider loading times',
            'Mobile - Larger sizes needed for small screens',
            'Social media - Bold, attention-grabbing fonts',
            'Branding - Consistent typography across all media',
          ],
        ),
      ],
    ),
    Module(
      number: 6,
      title: 'COLOR THEORY',
      icon: '🎨',
      color: const Color(0xFFEF4444),
      lessons: [
        Lesson(
          title: 'Color Psychology',
          content: 'Colors influence emotions and perceptions. Understanding color psychology helps designers communicate effectively.',
          bulletPoints: [
            'Red = energy, urgency, passion, danger',
            'Blue = trust, calm, professionalism, stability',
            'Green = nature, growth, health, money',
            'Black = luxury, elegance, sophistication',
            'Yellow = optimism, happiness, energy',
            'Orange = creativity, enthusiasm, warmth',
            'Purple = luxury, creativity, mystery',
            'White = purity, simplicity, cleanliness',
          ],
        ),
        Lesson(
          title: 'Color Wheel and Relationships',
          content: 'The color wheel shows relationships between colors. Understanding these relationships helps create harmonious color schemes.',
          bulletPoints: [
            'Primary colors - Red, blue, yellow (cannot be mixed)',
            'Secondary colors - Orange, green, purple (mix of primaries)',
            'Tertiary colors - Mix of primary and secondary',
            'Complementary - Opposite on color wheel (high contrast)',
            'Analogous - Adjacent colors (harmonious)',
            'Triadic - Three evenly spaced colors (balanced)',
          ],
        ),
        Lesson(
          title: 'Color Harmony',
          content: 'Color harmony creates pleasing color combinations. Different harmonies evoke different feelings.',
          bulletPoints: [
            'Complementary harmony - High contrast, vibrant',
            'Analogous harmony - Smooth, harmonious',
            'Triadic harmony - Balanced, diverse',
            'Split-complementary - Less intense than complementary',
            'Monochromatic - Variations of one color',
          ],
        ),
        Lesson(
          title: 'Color Temperature',
          content: 'Colors have temperature associations. Warm and cool colors create different moods.',
          bulletPoints: [
            'Warm colors - Red, orange, yellow (energy, warmth)',
            'Cool colors - Blue, green, purple (calm, professional)',
            'Warm colors advance (appear closer)',
            'Cool colors recede (appear farther)',
            'Temperature affects mood and perception',
          ],
        ),
        Lesson(
          title: 'Color in Branding',
          content: 'Color is crucial in branding. It helps establish brand identity and emotional connection.',
          bulletPoints: [
            'Brand colors should reflect brand personality',
            'Consistency is key across all touchpoints',
            'Consider cultural color associations',
            'Test colors in different contexts',
            'Color can increase brand recognition by 80%',
          ],
        ),
        Lesson(
          title: 'Color Accessibility',
          content: 'Designers must consider color accessibility to ensure designs are usable by everyone.',
          bulletPoints: [
            'Color contrast ratios for readability',
            'Don\'t rely solely on color to convey information',
            'Test designs for color blindness',
            'WCAG guidelines for web accessibility',
            'Use patterns or icons in addition to color',
          ],
        ),
      ],
    ),
    Module(
      number: 7,
      title: 'LAYOUT & COMPOSITION',
      icon: '📐',
      color: const Color(0xFF06B6D4),
      lessons: [
        Lesson(
          title: 'Rule of Thirds',
          content: 'The rule of thirds divides a design into nine equal sections using two horizontal and two vertical lines. Important elements should be placed along these lines or at their intersections. This technique creates more dynamic and visually interesting compositions than centering everything.',
        ),
        Lesson(
          title: 'Grid Systems',
          content: 'Grid systems provide structure and organization to layouts. They create consistency and help align elements.',
          bulletPoints: [
            'Column grids - Organize content into columns',
            'Modular grids - Rows and columns create modules',
            'Baseline grids - Align text to horizontal lines',
            'Manuscript grids - Simple single-column layouts',
            'Grids create professional, organized designs',
          ],
        ),
        Lesson(
          title: 'Visual Hierarchy',
          content: 'Visual hierarchy guides viewers through a design in order of importance. It helps communicate the message effectively.',
          bulletPoints: [
            'Size - Larger elements are more important',
            'Color - Bright colors draw attention',
            'Position - Top and center positions are noticed first',
            'Contrast - High contrast elements stand out',
            'Spacing - Isolated elements gain importance',
          ],
        ),
        Lesson(
          title: 'White Space',
          content: 'White space (negative space) is the empty area around design elements. It\'s crucial for readability and visual breathing room.',
          bulletPoints: [
            'White space improves readability',
            'It creates focus on important elements',
            'Too little white space feels cluttered',
            'Too much white space feels empty',
            'Balance is key',
          ],
        ),
        Lesson(
          title: 'Alignment Principles',
          content: 'Proper alignment creates order and professionalism. Aligned elements feel connected and intentional.',
          bulletPoints: [
            'Left alignment - Most common, easy to read',
            'Center alignment - Formal, balanced',
            'Right alignment - Less common, creates interest',
            'Justified - Clean edges, can create gaps',
            'Consistent alignment creates unity',
          ],
        ),
        Lesson(
          title: 'Focal Points',
          content: 'Focal points are areas that draw the viewer\'s attention first. Every design should have a clear focal point.',
          bulletPoints: [
            'Create one main focal point',
            'Use contrast to create focal points',
            'Position important elements strategically',
            'Size and color create focal points',
            'Focal points guide the viewer\'s eye',
          ],
        ),
      ],
    ),
    Module(
      number: 8,
      title: 'BRANDING DESIGN',
      icon: '🏷️',
      color: const Color(0xFF6366F1),
      lessons: [
        Lesson(
          title: 'Logo Design',
          content: 'A logo represents a brand visually. It\'s often the first thing people see and remember about a brand.',
          bulletPoints: [
            'Simple - Easy to recognize and remember',
            'Memorable - Stands out and is unforgettable',
            'Scalable - Works at any size',
            'Relevant - Reflects brand values and industry',
            'Versatile - Works in color and black & white',
            'Timeless - Won\'t look dated quickly',
          ],
        ),
        Lesson(
          title: 'Brand Identity Systems',
          content: 'Brand identity is more than just a logo. It\'s a complete visual system that represents a brand consistently.',
          bulletPoints: [
            'Logo variations - Horizontal, vertical, icon-only',
            'Color palette - Primary and secondary colors',
            'Typography - Brand fonts and usage guidelines',
            'Imagery style - Photography and illustration guidelines',
            'Iconography - Custom icons and graphics',
            'Applications - How to use across different media',
          ],
        ),
        Lesson(
          title: 'Brand Guidelines',
          content: 'Brand guidelines ensure consistent use of brand elements. They protect brand identity and maintain professionalism.',
          bulletPoints: [
            'Logo usage rules - Size, spacing, placement',
            'Color specifications - Exact color codes',
            'Typography guidelines - Font choices and hierarchy',
            'Do\'s and don\'ts - What to avoid',
            'File formats - When to use which format',
            'Guidelines maintain brand consistency',
          ],
        ),
        Lesson(
          title: 'Color Palette for Brands',
          content: 'Brand colors should be carefully chosen to reflect brand personality and create emotional connections.',
          bulletPoints: [
            'Primary colors - Main brand colors (1-2 colors)',
            'Secondary colors - Supporting colors',
            'Neutral colors - Grays, blacks, whites',
            'Accent colors - For highlights and CTAs',
            'Color meanings - What colors communicate',
            'Consistency across all brand touchpoints',
          ],
        ),
        Lesson(
          title: 'Typography in Branding',
          content: 'Typography is a crucial part of brand identity. It communicates brand personality and ensures consistency.',
          bulletPoints: [
            'Primary font - Main brand typeface',
            'Secondary font - For body text or contrast',
            'Font personality - Should match brand values',
            'Usage guidelines - When to use each font',
            'Custom fonts - Unique typography for brand',
            'Typography creates brand recognition',
          ],
        ),
      ],
    ),
    Module(
      number: 9,
      title: 'SOCIAL MEDIA DESIGN',
      icon: '📱',
      color: const Color(0xFF8B5CF6),
      lessons: [
        Lesson(
          title: 'Social Media Graphics',
          content: 'Social media designs must capture attention quickly. Users scroll fast, so designs need to be instantly engaging.',
          bulletPoints: [
            'Strong headline - Clear, compelling text',
            'Clear visual - Eye-catching imagery',
            'Brand identity - Consistent with brand',
            'Call to action - What should users do?',
            'Mobile-first - Most users view on phones',
            'Quick to understand - Instant message',
          ],
        ),
        Lesson(
          title: 'Platform-Specific Dimensions',
          content: 'Each social media platform has specific image dimensions. Using correct sizes ensures optimal display.',
          bulletPoints: [
            'Instagram - Square (1080x1080), Story (1080x1920)',
            'Facebook - Post (1200x630), Cover (820x312)',
            'Twitter - Header (1500x500), Post (1200x675)',
            'LinkedIn - Post (1200x627), Cover (1128x191)',
            'Pinterest - Pin (1000x1500)',
            'Always check current platform requirements',
          ],
        ),
        Lesson(
          title: 'Story Design',
          content: 'Stories are temporary, full-screen content. They require vertical, mobile-optimized designs.',
          bulletPoints: [
            'Vertical format - 9:16 aspect ratio',
            'Safe zones - Keep text away from edges',
            'Bold text - Large, readable fonts',
            'Short duration - Design for quick viewing',
            'Interactive elements - Polls, questions, stickers',
            'Brand consistency - Match brand colors and fonts',
          ],
        ),
        Lesson(
          title: 'Carousel Posts',
          content: 'Carousel posts allow multiple images in one post. They\'re great for storytelling and showcasing multiple products.',
          bulletPoints: [
            'Consistent design - All slides should feel connected',
            'Visual flow - Each slide leads to the next',
            'Clear narrative - Tell a story across slides',
            'First slide - Most important, should grab attention',
            'Brand consistency - Same colors, fonts, style',
            'Call to action - Usually on last slide',
          ],
        ),
        Lesson(
          title: 'Video Graphics',
          content: 'Video graphics include thumbnails, overlays, and animated graphics. They need to be engaging and on-brand.',
          bulletPoints: [
            'Thumbnails - Eye-catching preview images',
            'Text overlays - Add context to videos',
            'Animated graphics - Motion adds interest',
            'Brand elements - Logo, colors, fonts',
            'Readable text - Large, clear typography',
            'Optimized for mobile - Most viewing is on phones',
          ],
        ),
      ],
    ),
    Module(
      number: 10,
      title: 'PRINT DESIGN',
      icon: '🖨️',
      color: const Color(0xFFEC4899),
      lessons: [
        Lesson(
          title: 'RGB vs CMYK',
          content: 'RGB (Red, Green, Blue) is used for digital screens. CMYK (Cyan, Magenta, Yellow, Black) is used for printing. Designers must convert colors properly before printing to ensure accurate color reproduction.',
          bulletPoints: [
            'RGB - Additive color model for screens',
            'CMYK - Subtractive color model for print',
            'RGB has wider color gamut than CMYK',
            'Always convert to CMYK before printing',
            'Colors may look different after conversion',
            'Test prints help ensure color accuracy',
          ],
        ),
        Lesson(
          title: 'Print Specifications',
          content: 'Understanding print specifications ensures your designs print correctly. Different projects require different settings.',
          bulletPoints: [
            'Resolution - 300 DPI for print (vs 72 DPI for web)',
            'Bleed - Extra area that gets trimmed (usually 0.125")',
            'Trim size - Final printed size',
            'Safe area - Keep important content away from edges',
            'Margins - Space between content and edge',
            'Always check with printer for specific requirements',
          ],
        ),
        Lesson(
          title: 'Bleed and Margins',
          content: 'Bleed and margins are crucial for print design. They ensure designs print correctly without unwanted white edges.',
          bulletPoints: [
            'Bleed - Extends beyond trim line (prevents white edges)',
            'Trim line - Where the design gets cut',
            'Safe area - Keep text and important elements inside',
            'Standard bleed - 0.125" (3mm) on all sides',
            'Margins - Space from edge to content',
            'Always include bleed in print files',
          ],
        ),
        Lesson(
          title: 'Paper Types',
          content: 'Different paper types affect how designs look and feel. Understanding paper options helps create better print designs.',
          bulletPoints: [
            'Coated paper - Smooth, glossy finish (magazines)',
            'Uncoated paper - Absorbs ink, matte finish (books)',
            'Cardstock - Thick, durable (business cards)',
            'Textured paper - Adds tactile interest',
            'Paper weight - Measured in GSM or lbs',
            'Paper choice affects color appearance',
          ],
        ),
        Lesson(
          title: 'Print File Formats',
          content: 'Different print projects require different file formats. Using the correct format ensures quality printing.',
          bulletPoints: [
            'PDF - Most common, preserves formatting',
            'EPS - Vector format for logos and graphics',
            'TIFF - High-quality raster images',
            'AI/PSD - Source files for editing',
            'Always embed fonts in PDFs',
            'Use high-resolution images (300 DPI)',
          ],
        ),
      ],
    ),
    Module(
      number: 11,
      title: 'DESIGN WORKFLOW',
      icon: '🔄',
      color: const Color(0xFFF59E0B),
      lessons: [
        Lesson(
          title: 'Professional Design Process',
          content: 'Professional designers follow a workflow.',
          bulletPoints: [
            'Step 1 — Research - Understand the client and audience',
            'Step 2 — Concept - Sketch ideas and concepts',
            'Step 3 — Design - Create the design digitally',
            'Step 4 — Feedback - Revise the design',
            'Step 5 — Delivery - Export final files',
          ],
        ),
      ],
    ),
    Module(
      number: 12,
      title: 'PORTFOLIO BUILDING',
      icon: '📚',
      color: const Color(0xFF10B981),
      lessons: [
        Lesson(
          title: 'Building Your Portfolio',
          content: 'A strong portfolio showcases your best work and demonstrates your skills. It\'s essential for getting design jobs and clients.',
          bulletPoints: [
            'Logos - Show brand identity skills',
            'Posters - Demonstrate layout and composition',
            'Social media designs - Show versatility',
            'Brand identity projects - Complete brand systems',
            'UI designs - Digital design skills',
            'Select only your best work (quality over quantity)',
          ],
        ),
        Lesson(
          title: 'Portfolio Presentation',
          content: 'How you present your work matters as much as the work itself. Good presentation makes your portfolio stand out.',
          bulletPoints: [
            'High-quality images - Professional photography or mockups',
            'Consistent style - Cohesive portfolio design',
            'Clear navigation - Easy to browse',
            'Project descriptions - Explain your process',
            'Before/after - Show problem-solving',
            'Keep it updated - Add new work regularly',
          ],
        ),
        Lesson(
          title: 'Case Studies',
          content: 'Case studies tell the story behind your designs. They show your thinking process and problem-solving skills.',
          bulletPoints: [
            'Problem - What challenge did you solve?',
            'Research - How did you approach it?',
            'Process - Show sketches and iterations',
            'Solution - Final design and rationale',
            'Results - Impact or outcomes',
            'Case studies demonstrate expertise',
          ],
        ),
        Lesson(
          title: 'Online Portfolio Platforms',
          content: 'Many platforms make it easy to create and host your portfolio. Choose one that fits your needs and style.',
          bulletPoints: [
            'Behance - Popular, free, great for discovery',
            'Dribbble - Community-focused, high-quality work',
            'Adobe Portfolio - Integrated with Creative Cloud',
            'Squarespace - Professional templates',
            'WordPress - Customizable, self-hosted',
            'Custom website - Full control, unique design',
          ],
        ),
        Lesson(
          title: 'Portfolio Critique',
          content: 'Getting feedback on your portfolio helps you improve. Regular critiques ensure your portfolio stays strong.',
          bulletPoints: [
            'Peer review - Get feedback from other designers',
            'Mentor feedback - Learn from experienced designers',
            'Client feedback - What do clients respond to?',
            'Regular updates - Remove weak work, add new',
            'Test with target audience - Does it resonate?',
            'Continuous improvement - Always evolving',
          ],
        ),
      ],
    ),
    Module(
      number: 13,
      title: 'FREELANCING',
      icon: '💼',
      color: const Color(0xFFEF4444),
      lessons: [
        Lesson(
          title: 'Freelancing as a Graphic Designer',
          content: 'Freelancing offers flexibility and independence. Many graphic designers work as freelancers, either full-time or part-time.',
          bulletPoints: [
            'Upwork - Large platform, competitive',
            'Fiverr - Gig-based, quick projects',
            'Freelancer - Global marketplace',
            '99designs - Design contests',
            'Direct clients - Best rates, relationships',
            'Networking - Build connections in your industry',
          ],
        ),
        Lesson(
          title: 'Pricing Strategies',
          content: 'Pricing your work correctly is crucial for success. Underpricing hurts you and the industry. Overpricing loses clients.',
          bulletPoints: [
            'Hourly rate - Based on experience and location',
            'Project-based - Fixed price for complete project',
            'Value-based - Price based on value to client',
            'Package deals - Multiple services bundled',
            'Research market rates in your area',
            'Factor in revisions and communication time',
          ],
        ),
        Lesson(
          title: 'Client Communication',
          content: 'Good communication is essential for successful freelancing. Clear communication prevents misunderstandings and builds trust.',
          bulletPoints: [
            'Set expectations - Clear project scope',
            'Regular updates - Keep clients informed',
            'Ask questions - Clarify requirements',
            'Professional tone - Always be respectful',
            'Document everything - Emails, contracts, agreements',
            'Timely responses - Reply within 24 hours',
          ],
        ),
        Lesson(
          title: 'Contracts and Agreements',
          content: 'Contracts protect both you and your clients. Always use written agreements for projects.',
          bulletPoints: [
            'Scope of work - What you\'ll deliver',
            'Timeline - Deadlines and milestones',
            'Payment terms - When and how you get paid',
            'Revision policy - How many revisions included',
            'Ownership rights - Who owns the final work',
            'Cancellation policy - What happens if project ends early',
          ],
        ),
        Lesson(
          title: 'Marketing Yourself',
          content: 'As a freelancer, you need to market yourself to find clients. Building your brand and online presence is essential.',
          bulletPoints: [
            'Portfolio website - Showcase your work',
            'Social media - Share work and connect',
            'Networking - Attend events, join communities',
            'Content creation - Blog, tutorials, tips',
            'Testimonials - Client reviews build trust',
            'Specialize - Become known for specific skills',
          ],
        ),
      ],
    ),
    Module(
      number: 14,
      title: 'ADVANCED DESIGN THEORY',
      icon: '🧠',
      color: const Color(0xFF06B6D4),
      lessons: [
        Lesson(
          title: 'Advanced Design Concepts',
          content: 'Advanced designers study visual psychology and design theory to create more effective and meaningful designs.',
          bulletPoints: [
            'Gestalt principles - How people perceive visual elements',
            'Visual hierarchy - Guiding attention effectively',
            'Semiotics - Meaning of signs and symbols',
            'User perception - How users interpret designs',
            'Cognitive load - Reducing mental effort',
            'Design thinking - Problem-solving approach',
          ],
        ),
        Lesson(
          title: 'Gestalt Principles',
          content: 'Gestalt principles explain how people perceive and organize visual information. Understanding these principles improves design effectiveness.',
          bulletPoints: [
            'Proximity - Elements close together are grouped',
            'Similarity - Similar elements are grouped',
            'Closure - People complete incomplete shapes',
            'Continuity - Eyes follow smooth lines',
            'Figure/Ground - Distinguishing subject from background',
            'Common fate - Elements moving together are grouped',
          ],
        ),
        Lesson(
          title: 'Visual Hierarchy Deep Dive',
          content: 'Visual hierarchy is crucial for effective communication. Advanced understanding helps create more intuitive designs.',
          bulletPoints: [
            'Size hierarchy - Larger = more important',
            'Color hierarchy - Bright colors draw attention',
            'Position hierarchy - Top and center are noticed first',
            'Contrast hierarchy - High contrast stands out',
            'Typography hierarchy - Font size, weight, style',
            'Z-pattern and F-pattern - How eyes scan pages',
          ],
        ),
        Lesson(
          title: 'Semiotics in Design',
          content: 'Semiotics is the study of signs and symbols. Understanding semiotics helps designers communicate more effectively.',
          bulletPoints: [
            'Signs - Anything that stands for something else',
            'Icons - Resemble what they represent',
            'Symbols - Arbitrary but culturally understood',
            'Indexes - Point to something else',
            'Cultural context - Meanings vary by culture',
            'Symbolic meaning - Deeper associations',
          ],
        ),
        Lesson(
          title: 'User Perception and Cognition',
          content: 'Understanding how users perceive and process visual information helps create more effective designs.',
          bulletPoints: [
            'Attention - What users notice first',
            'Memory - How users remember information',
            'Pattern recognition - Users recognize patterns quickly',
            'Cognitive load - Mental effort required',
            'Chunking - Grouping information for easier processing',
            'Affordances - What actions are possible',
          ],
        ),
      ],
    ),
    Module(
      number: 15,
      title: 'AI IN GRAPHIC DESIGN',
      icon: '🤖',
      color: const Color(0xFF6366F1),
      lessons: [
        Lesson(
          title: 'Modern AI Tools',
          content: 'Modern designers use AI tools to speed up workflow and enhance creativity. AI is a powerful assistant, not a replacement for designers.',
          bulletPoints: [
            'Image generation - Create visuals from text prompts',
            'Background removal - Automatic background removal',
            'Concept generation - Generate design ideas',
            'Design inspiration - AI-powered mood boards',
            'Color palette generation - AI color suggestions',
            'Layout suggestions - AI-powered composition',
          ],
        ),
        Lesson(
          title: 'Specific AI Tools',
          content: 'Many AI tools are available for designers. Understanding which tools to use for what tasks is important.',
          bulletPoints: [
            'Midjourney - High-quality image generation',
            'DALL-E - OpenAI\'s image generation',
            'Adobe Firefly - Integrated with Adobe tools',
            'Canva AI - Accessible AI design tools',
            'Remove.bg - Background removal',
            'ChatGPT - Design ideation and copywriting',
          ],
        ),
        Lesson(
          title: 'AI Workflow Integration',
          content: 'AI works best when integrated into your existing workflow. It should enhance, not replace, your creative process.',
          bulletPoints: [
            'Ideation phase - Generate concepts quickly',
            'Asset creation - Generate images and graphics',
            'Time-saving tasks - Remove backgrounds, upscale images',
            'Inspiration - Use AI for mood boards',
            'Iteration - Quickly explore variations',
            'AI + human creativity = best results',
          ],
        ),
        Lesson(
          title: 'Ethical Considerations',
          content: 'Using AI in design raises ethical questions. Designers should understand these considerations and use AI responsibly.',
          bulletPoints: [
            'Copyright - Who owns AI-generated content?',
            'Originality - Is AI-generated work original?',
            'Attribution - Should AI be credited?',
            'Job displacement - How AI affects designers',
            'Bias - AI can perpetuate biases',
            'Transparency - Disclose AI use to clients',
          ],
        ),
        Lesson(
          title: 'AI Limitations',
          content: 'AI has limitations. Understanding what AI can and cannot do helps you use it effectively.',
          bulletPoints: [
            'Lacks human creativity and intuition',
            'May produce generic or clichéd designs',
            'Requires human oversight and refinement',
            'Cannot understand brand context fully',
            'May not meet specific client needs',
            'Human judgment is still essential',
          ],
        ),
      ],
    ),
  ],
);
