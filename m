From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 Feb 2012 12:35:50 +0000
Subject: [GIT PULL] imx_v6_v7_defconfig updates for v3.4
In-Reply-To: <20120228023846.GG13886@S2101-09.ap.freescale.net>
References: <20120228023846.GG13886@S2101-09.ap.freescale.net>
Message-ID: <201202281235.50844.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 February 2012, Shawn Guo wrote:
> Please pull the following imx_v6_v7_defconfig updates for v3.4.  The
> first patch was generated some time ago, so it looks not so consistent
> with another one on subject.  Will try to make it better in the future.
> 
> Regards,
> Shawn
> 
> The following changes since commit 6b21d18ed50c7d145220b0724ea7f2613abf0f95:
> 
>   Linux 3.3-rc5 (2012-02-25 12:18:16 -0800)
> 
> are available in the git repository at:
>   git://git.linaro.org/people/shawnguo/linux-2.6.git imx/defconfig

I've put it into the next/soc branch because the changes are for the
global defconfig. We could theoretically have an overall branch for
defconfig updates, but most of these tend to be related to some other
changes, so I'm leaving that for now.

Thanks,

	Arnd
