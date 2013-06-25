From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Tue, 25 Jun 2013 13:34:31 +0800
Subject: [PATCH] dmaengine: Add hisilicon k3 DMA engine driver
In-Reply-To: <10541174.SUr9yD0veu@wuerfel>
References: <1371444872-26994-1-git-send-email-zhangfei.gao@linaro.org>
 <201306211341.53928.arnd@arndb.de>
 <CAMj5Bkg_4G9n9BaQjA-Xj2p8jGO8PZxNW7E7jOeWMMZa5sH6yQ@mail.gmail.com>
 <10541174.SUr9yD0veu@wuerfel>
Message-ID: <CAMj5BkgKSmDWZ8=tOEvj7mhf-zfZVtO1F0eKTN6UzjYepHmMbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 12:15 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 24 June 2013 16:49:08 zhangfei gao wrote:
>>
>> Dear Arnd & Vinod
>>
>> The suggestion of using dma_get_slave_channel instead of filter works here.
>> Dma driver should modify accordingly.
>
> The changes all look good to me, thanks a lot for following up!
>
> However, you should really follow the procedure for posting patches even
> if it's just for the sake of discussion:
>
> * always provide a signed-off-by and a patch description
> * use an email client that doesn't break whitespace
> * I would have split this up into two separate patches, one for the
>   subsystem and one for the new driver.

Thanks Arnd for for kind education,
Will send two patches, one is subsystem, the other is updated host driver.

Thanks
