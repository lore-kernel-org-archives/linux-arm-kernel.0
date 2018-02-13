From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 13 Feb 2018 12:18:05 -0800
Subject: [PATCH v10 0/3] arm: npcm: add basic support for Nuvoton BMCs
In-Reply-To: <20180213200959.160157-1-brendanhiggins@google.com>
References: <20180213200959.160157-1-brendanhiggins@google.com>
Message-ID: <b33b48ba-35ef-d98e-fa52-f70ed0953dcc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/2018 12:09 PM, Brendan Higgins wrote:
> Addressed comments from:
>  - Joel: https://www.spinics.net/lists/arm-kernel/msg634074.html
>  - Arnd: https://www.spinics.net/lists/arm-kernel/msg634091.html
> 
> Summary of changes since previous update:
>  - Replaced "nuvoton,npcm7xx-smp" compatibility string with
>    "nuvoton,npcm750-smp".
>  - Fixed some whitespace issues.
>  - Added EVB DTS to Makefile.
> 
> All changes tested on Nuvoton NPCM750 EVB.
> 

Thanks for keeping me CC, FWIW: Reviewed-by: Florian Fainelli
<f.fainelli@gmail.com>

FWIW, I don't have a vested interest in BMCs in general, just happened
to do a drive by review of your SMP code, no need to CC me on future
submissions (e.g: boards, drivers etc.). Cheers
-- 
Florian
