From: olof@lixom.net (Olof Johansson)
Date: Sat, 9 Feb 2013 18:34:32 -0800
Subject: [GIT PULL] mxs device tree changes for 3.9
In-Reply-To: <20130205060413.GE10807@S2101-09.ap.freescale.net>
References: <20130205060413.GE10807@S2101-09.ap.freescale.net>
Message-ID: <20130210023432.GD25302@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 02:04:15PM +0800, Shawn Guo wrote:
> The following changes since commit a49f0d1ea3ec94fc7cf33a7c36a16343b74bd565:
> 
>   Linux 3.8-rc1 (2012-12-21 17:19:00 -0800)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/shawnguo/linux-2.6.git tags/mxs-dt-3.9
> 
> for you to fetch changes up to 0943b96058c4262b4e4cd05398f42e8730d5ee08:
> 
>   ARM: mxs: dts: Add rotary encoder to the CFA-10049 (2013-01-31 22:31:19 +0800)

Pulled, thanks.

It'd be nice to see the remaining drivers converted such that board file
updates aren't needed for new platform support. Looks like we're nearly there,
just a few more pieces in this case.


-Olof
