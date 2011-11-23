From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Nov 2011 21:15:42 +0000
Subject: [GIT PULL] imx6q: fix for v3.2-rc
In-Reply-To: <20111117131901.GL14656@S2100-06.ap.freescale.net>
References: <20111117131901.GL14656@S2100-06.ap.freescale.net>
Message-ID: <201111232115.42689.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 November 2011, Shawn Guo wrote:
> Please pull the imx6q fix below for v3.2-rc.
> 
> Regards,
> Shawn
> 
> The following changes since commit cfcfc9eca2bcbd26a8e206baeb005b055dbf8e37:
> 
>   Linux 3.2-rc2 (2011-11-15 15:02:59 -0200)
> 
> are available in the git repository at:
>   git://git.linaro.org/people/shawnguo/linux-2.6.git imx6q/fixes
> 
> Richard Zhao (1):
>       ARM: imx6q: move clock register map to machine_desc.map_io
> 

Hi Shawn and Richard,

I've applied the patch to the 'fixes' branch since it seems correct,
but please explain to me what bug this actually fixes. The changelog
does not actually mention why this is broken or why the fix is needed
in 3.2.

	Arnd
