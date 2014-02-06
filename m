From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 6 Feb 2014 15:57:50 +0800
Subject: emmc on imx6 sabresd
In-Reply-To: <20140129100321.GA32101@frolo.macqel>
References: <20140129100321.GA32101@frolo.macqel>
Message-ID: <20140206075748.GC3708@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 29, 2014 at 11:03:21AM +0100, Philippe De Muyter wrote:
> Hi Shawn,
> 
> I try to use the emmc on my sabresd board and on a similar custom board
> using 3.13, and I have just discovered by reading Internet that it was
> not supported up to some weeks ago.  Is there a git tree somewhere that
> has a branch containing 3.13 or linux-next and all the fixes for emmc on
> sabresd ?

I think it will just work if you apply the patch [1] on top of
v3.14-rc1.

Shawn

[1] http://www.spinics.net/lists/linux-mmc/msg23039.html
