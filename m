From: Jon.Povey@racelogic.co.uk (Jon Povey)
Date: Tue, 19 Jul 2011 07:28:19 +0100
Subject: [PATCH] davinci: fix DM365 EVM video input mux bits
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024BCEF73E@dbde02.ent.ti.com>
Message-ID: <70E876B0EA86DD4BAF101844BC814DFE0B4E0859D7@Cloud.RL.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hadli, Manjunath wrote:
> Jon,
>
> The fix looks correct. As a part of a different
> implementation which will go soon upstream, this has been
> taken care of, where we have used macros
> CPLD_VIDEO_INPUT_MUX_TVP7002    0x1
> CPLD_VIDEO_INPUT_MUX_IMAGER     0x2
>
> So, if you can do the same, it will look better.

If you have a patch you can split out that has your defines
where and how you want them then great.

Otherwise I'd suggest just getting this or something equivalent
in to fix the bug first, and reimplement it later.

--
Jon Povey
jon.povey at racelogic.co.uk

Racelogic is a limited company registered in England. Registered number 2743719 .
Registered Office Unit 10, Swan Business Centre, Osier Way, Buckingham, Bucks, MK18 1TB .

The information contained in this electronic mail transmission is intended by Racelogic Ltd for the use of the named individual or entity to which it is directed and may contain information that is confidential or privileged. If you have received this electronic mail transmission in error, please delete it from your system without copying or forwarding it, and notify the sender of the error by reply email so that the sender's address records can be corrected. The views expressed by the sender of this communication do not necessarily represent those of Racelogic Ltd. Please note that Racelogic reserves the right to monitor e-mail communications passing through its network
