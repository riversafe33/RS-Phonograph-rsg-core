Config = {}

Config.PhonoItems = "phonograph"

Config.Keys = {
    moveForward    = 0x6319DB71, -- Arrow Up
    moveBackward   = 0x05CA7C52, -- Arrow Down
    moveLeft       = 0xA65EBAB4, -- Arrow Left
    moveRight      = 0xDEB34313, -- Arrow Right
    rotateLeftZ    = 0xB2F377E8, -- F
    rotateRightZ   = 0x760A9C6F, -- G    
    speedPlace     = 0x4F49CC4C, -- 3
    moveUp         = 0xB03A913B, -- 7
    moveDown       = 0x42385422, -- 8
    cancelPlace    = 0xE30CD707, -- R
    confirmPlace   = 0xC7B5340A, -- ENTER
}

Config.Promp = {
    openmanuUi = "Open Menu",
    Collect = "Collect",
}

Config.Input = {
    Confirm = "Confirm",
    MinMax = "0.01 to 5",
    Change = "Only numbers between 0.01 and 5 are allowed",
    Speed = "Change Speed",
}

Config.Notify = {
    Phono = "Phonograph",
    PlaySelect = "The selected song is playing",
    PlayMessage = "The music is playing",
    InvalidUrlMessage = "Invalid URL",
    InvalidSound = "Invalid song data",
    StopMessage = "The music has stopped",
    VolumeUpMessage = "Volume increased to %d%%",
    MaxVolumeMessage = "Volume is already at maximum.",
    VolumeDownMessage = "Volume decreased to %d%%",
    MinVolumeMessage = "Volume is already at minimum.",
    UnregisteredMessage = "The phonograph is not registered!",
    NoPhonographMessage = "No valid phonograph in front of you",
    Already = "You already have a phonograph placed!",
    Place = "Phonograph placed!",
    Cancel = "Placement canceled.",
    TooFar = "Too far to collect the phonograph",
    Custom = "Custom songs are disabled",
    LoopOnMessage = "Loop enabled.",
    LoopOffMessage = "Loop disabled.",
    Picked = "You have collected your phonograph",
    Dont = "This phonograph does not belong to you",
}

Config.ControlTranslations = {
    Title   = "Controls",
    Move    = "[← ↑ ↓ →] - Move object",
    Rotate  = "[F/G]     - Rotate object",
    Height  = "[7/8]     - Raise/Lower",
    Confirm = "[ENTER]   - Confirm position",
    Cancel  = "[R]       - Cancel placement",
    Speed   = "[3]       - Adjust speed"
}

Config.MusicTranslations = {
    Volume   = "📯 Volume",
    AudioURL = "◎ Audio URL",
    SwitchToList = "Song List",
    SelectSong = "🎵 Select a song",
    SwitchToUrl = "URL Sond"
}

Config.SoundDistance = 10      -- Maximum audible distance for the music
Config.WithEffect = false      -- Set to true if you want the sound effect to play
Config.VolumeEffect = 0.3      -- Change the effect volume here
Config.AllowCustomSongs = true -- If set to false, people will not be able to play their own songs, only those from the Choose a Song list
Config.AllowListSongs = true   -- if set to true, the list of songs from Config.SongList will appear in the menu; if set to false, the option to choose a song will not be shown

Config.SongList = {
    { label = "Émile Waldteufel - Estudiantina", url = "https://youtu.be/q6R5M52lqlw?list=PLJe4EftqVf-ujHNCbcZBwRvwkYuiuHuGl" },
    { label = "Johann Strauss - The Bat Waltz", url = "https://www.youtube.com/watch?v=QVC1jMRVNAw" },
    { label = "Johann Strauss - Voices of Spring", url = "https://www.youtube.com/watch?v=Vh0KkW42iiY" },
    { label = "Johann Strauss - The Blue Danube", url = "https://www.youtube.com/watch?v=o915AjZtZy4" },
    { label = "Johann Strauss - Tales from the Woods", url = "https://www.youtube.com/watch?v=yZGfZDyHkM0" },
    { label = "Johann Strauss - Accelerations", url = "https://www.youtube.com/watch?v=PscKxtzI3Ok" },
    { label = "Johann Strauss - Artist's Life", url = "https://www.youtube.com/watch?v=AQWkpwE2lqA" },
    { label = "Johann Strauss - Eat, Drink and Be Merry", url = "https://www.youtube.com/watch?v=_YRAIphouQY" },
    { label = "Johann Strauss - Emperor Waltz", url = "https://www.youtube.com/watch?v=f91F2RKO7fQ" },
    { label = "Amazing Grace", url = "https://www.youtube.com/watch?v=QJSIlhxksAQ" },
    { label = "Red River Valley", url = "https://www.youtube.com/watch?v=YdussoFmKC0" },
    { label = "I Wish I Was In Dixie Land", url = "https://youtu.be/5OKdbc0DYpM?list=PLCyUlNkbObRZ4k-tEvaLwrNmjUcsQPhfE" },
    { label = "Oh! Susanna", url = "https://youtu.be/-9qRad6pWQI?list=PLCyUlNkbObRZ4k-tEvaLwrNmjUcsQPhfE" },
    { label = "Little Brown Jug", url = "https://youtu.be/07T7rREzYMc?list=PLCyUlNkbObRZ4k-tEvaLwrNmjUcsQPhfE" },
    { label = "Take Me Home", url = "https://youtu.be/DOo-qDb_me0?list=PLCyUlNkbObRZ4k-tEvaLwrNmjUcsQPhfE" },
    { label = "The Rose of Alabama", url = "https://youtu.be/Pr1QnXGTk-o?list=PLCyUlNkbObRZ4k-tEvaLwrNmjUcsQPhfE" },
    { label = "Oh! Dem Golden Slippers!", url = "https://youtu.be/cUZ5XzsHN-c?list=PLCyUlNkbObRZ4k-tEvaLwrNmjUcsQPhfE" },
    { label = "Camptown Races", url = "https://youtu.be/49_QHBR4OxE?list=PLCyUlNkbObRZ4k-tEvaLwrNmjUcsQPhfE" },
    { label = "In The Garden", url = "https://www.youtube.com/watch?v=ob3P0odQ7Ic" },
    { label = "Yellow Rose of Texas", url = "https://youtu.be/6HgMXpYYUjo?list=PLCyUlNkbObRZ4k-tEvaLwrNmjUcsQPhfE" },
    { label = "Carry Me Back to Old Virginny", url = "https://youtu.be/PyhQYOxTHaw?list=PLCyUlNkbObRZ4k-tEvaLwrNmjUcsQPhfE" },
    { label = "Shall We Gather at the River", url = "https://www.youtube.com/watch?v=JfUYN0F5jEI" },
    { label = "Gerardo Nuñez - Remache", url = "https://www.youtube.com/watch?v=HgR_jvjPkAo" },
    { label = "Under the Stars", url = "https://www.youtube.com/watch?v=v4Heu4XMN-g" },
    { label = "Cherokee Morning Song - Walela", url = "https://www.youtube.com/watch?v=96sU0HW8JrE" },
    { label = "Chant of Happiness & Hope", url = "https://www.youtube.com/watch?v=6nOPPuuWBec" },
    { label = "Lakota National Anthem", url = "https://www.youtube.com/watch?v=T-0vfrxkrxg" },
    { label = "Zuni Sunrise", url = "https://www.youtube.com/watch?v=UWcqYlzMg0g" },
    { label = "Lakota Love Song", url = "https://www.youtube.com/watch?v=bUHJ9dxM9_g" },   
}
