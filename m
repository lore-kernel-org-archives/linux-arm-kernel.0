From: jiujin.hong@mid-fun.com (tommy)
Date: Thu, 22 Oct 2009 10:58:09 +0800
Subject: about ARM11 WM9715 no sound when resume
Message-ID: <1256180289.11383.0.camel@tommy-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,all!

Platform:Linux 2.6.24.2
MCU:Samsung ARM11
Codec:WM9715 AC97

Problem:
              When MCU resume from suspend,no sound but can also
playback from start to end!
               It has sound only by modifing sound setting applicantion
program!
               I see ubuntu alsa resume,it is use alsa-force(reloading
alsa driver to fix that problem),is that only way to fix that issue in
ARM too?
               My driver is built-in!
               I try to write volume reg to codec when resume,also the
same problem!
               
Thanks first!

Tommy at China
