From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Oct 2011 18:24:44 +0200
Subject: [GIT PULL] Samsung cleanup-3 for v3.2
In-Reply-To: <000401cc8c87$2ab684e0$80238ea0$%kim@samsung.com>
References: <000401cc8c87$2ab684e0$80238ea0$%kim@samsung.com>
Message-ID: <201110201824.44337.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 October 2011, Kukjin Kim wrote:
> This is a 3rd cleanup request for v3.2 Samsung stuff which includes cleanup
> resources and platform devices into one plat-samsung directory. As I said
> during review in mailing list, this is needed to reduce plat- directories
> and help to keep easily platform devices.
> 
> Please pull from:
>  git://github.com/kgene/linux-samsung.git next-samsung-cleanup-3
> 
> Since this moves a lot of files, I think you can pull this into your
> next/cleanup2 which will be merged late during upcoming merge window.

Yes, makes sense. As you suggested, I've pulled into next/cleanup2.
The code size reduction looks very nice.

Thanks and sorry for the delay.

	Arnd
