From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 5 Mar 2013 22:21:03 +0000
Subject: [PATCH 00/23] RFC: exynos multiplatform support
In-Reply-To: <681263925.o7yR7PPoHR@flatron>
References: <1362505353-8873-1-git-send-email-arnd@arndb.de>
 <201303052154.22857.arnd@arndb.de> <681263925.o7yR7PPoHR@flatron>
Message-ID: <201303052221.03250.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 March 2013, Tomasz Figa wrote:
> AFAIR, the PL080 in S3C64xx is a slightly customized variant and requires 
> some modifications to the driver. However I'm saying this only based on 
> what I remember from the past, as I haven't checked current version of the 
> driver yet, so it's possible that it has been modified already.
> 
> I believe I will eventually have to take a look at it anyway, as it's a 
> necessary step towards S3C64xx DT support.

Ok. Let me know if you need any help adding DT support to the pl08x driver.
It would be nice to have that for SPEAr, Versatile and lpce32xx as well.

All three currently have full DT support except for the DMA binding,
since the common code for that was only added in 3.9-rc1.

	Arnd
