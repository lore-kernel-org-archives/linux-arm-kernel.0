From: pali.rohar@gmail.com (Pali =?utf-8?B?Um9ow6Fy?=)
Date: Fri, 20 Jan 2017 14:38:30 +0100
Subject: Nokia N900: microphone mixers
In-Reply-To: <20170120133159.GA5241@amd>
References: <20170112181826.GA28290@amd> <201701121934.19810@pali>
 <20170114225614.GA25321@amd> <201701150100.54214@pali>
 <20170115100533.GA15816@amd>
 <40dbce4e-d99d-d77d-e682-5b004c70ca40@bitmer.com>
 <d2c78625-565a-86ec-a03e-f15ae071942a@ti.com>
 <ecdc073b-d83f-ba7d-89bf-da8899414217@bitmer.com>
 <20170120133159.GA5241@amd>
Message-ID: <20170120133830.GF32502@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 January 2017 14:31:59 Pavel Machek wrote:
> Hi!
> 
> Do you have any idea how to control the microphone? I'd like the audio
> source to be microphone on headset (not the built in one). So I run
> alsamixer, set everything in "capture" section to zero... and I still
> get the audio from the internal microphone :-(.
> 
> Tested with arecord | aplay.
> 
> Any ideas?

Hi! Try to set Jack Function to Headset or enable b HS Mic.

-- 
Pali Roh?r
pali.rohar at gmail.com
