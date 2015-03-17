From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Tue, 17 Mar 2015 16:34:33 +0000
Subject: XIP_KERNEL and !ARCH_MULTIPLATFORM
In-Reply-To: <CAMuHMdUS84s=uLYVk8BtRoKFmBzw7aT1eQCfGF1nx22hTqf15A@mail.gmail.com>
References: <HK2PR06MB0561CC16649A9C1F341CC6648A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdUR3oLp3RMcdEkMiqX92bosYE=f8tOKA1L_y59KMPuEJw@mail.gmail.com>
 <HK2PR06MB05613B2FBF8466204FA98A9D8A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdU3J1uzD5VAgHgF5NNzw_E7Njf7wU7kJ7oPuCKm7N_Arg@mail.gmail.com>
 <HK2PR06MB0561FE47407CA32AA8DDEFCF8A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdUS84s=uLYVk8BtRoKFmBzw7aT1eQCfGF1nx22hTqf15A@mail.gmail.com>
Message-ID: <HK2PR06MB0561E2FEA01A94ED8DF4079E8A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

> DEBUG_LL=y may help you here. It's easier than doing a post-mortem analysis on __log_buf from U-Boot.

That didn't exist for me in 3.14 for RZ/A1. I thought I saw someone add it (I started to work on it...but didn't finish).

> 3.14 has (limited) RZ/A1H multi-platform support. Perhaps you can try getting XIP to work with a multi-platform v3.14 kernel first, and find out what broke in newer versions later?

I think first I'll just go back to how I debugged XIP in 3.14.....JTAG and a disassembly window. It's not pretty, but it's what I have available to work with.

Chris
