From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 10 Aug 2013 23:25:16 +0200
Subject: [PATCH v2 00/11] dma: pdma: some patches needed for PXA DT
 environments
In-Reply-To: <1376153545-14361-1-git-send-email-zonque@gmail.com>
References: <1376153545-14361-1-git-send-email-zonque@gmail.com>
Message-ID: <201308102325.16609.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 10 August 2013, Daniel Mack wrote:
> This is v2 of my series to add more features to the pdma driver.
> 
> Changes from v1 -> v2:
> 
>  - drop the two patches from Xiang Wang that are already applied to
>    Vinod's next branch
>  - add another patch to cleanup the unlocking path in lookup_phy(),
>    as suggested by Ezequiel
>  - provide an own xlate function rather than using
>    of_dma_simple_xlate(), as suggested by Arnd
> 
> 
> There's still an open topic with the DALGN flag, as Xiang Wang pointed
> out. According to him, there's a chance we need an alternative way of
> forcing the driver into byte-align mode, but that can still be done in
> an additional patch later.
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
