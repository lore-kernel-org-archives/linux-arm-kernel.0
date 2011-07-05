From: naveenkrishna.ch@gmail.com (Naveen Krishna Ch)
Date: Tue, 5 Jul 2011 16:54:41 +0530
Subject: [PATCH 0/2] ARM: Samsung: I2C code cleanup
In-Reply-To: <1309519992-3026-1-git-send-email-ch.naveen@samsung.com>
References: <1309519992-3026-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <CAHfPSqA6YtSeb-A7QPTuVSgjFuPyF52REw=Vit6xU31B+RenHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

Can you kindly, review the following patchset and let me know the comments.

On 1 July 2011 17:03, Naveen Krishna Chatradhi <ch.naveen@samsung.com> wrote:
> Does the same job, while saving few lines of code.
>
> ?o To Kukjin Kim, Sangbeom Kim and Ben Dooks
>
> Naveen Krishna Chatradhi (2):
> ?ARM: Samsung: Use generic set_plat_data function
> ?ARM: Samsung: Cleanup I2C code in plat-samsung
>
> ?arch/arm/plat-samsung/dev-i2c0.c ? ? ? ? | ? 14 ++++++--------
> ?arch/arm/plat-samsung/dev-i2c1.c ? ? ? ? | ? 24 ++++++++----------------
> ?arch/arm/plat-samsung/dev-i2c2.c ? ? ? ? | ? 24 ++++++++----------------
> ?arch/arm/plat-samsung/dev-i2c3.c ? ? ? ? | ? 24 ++++++++----------------
> ?arch/arm/plat-samsung/dev-i2c4.c ? ? ? ? | ? 24 ++++++++----------------
> ?arch/arm/plat-samsung/dev-i2c5.c ? ? ? ? | ? 24 ++++++++----------------
> ?arch/arm/plat-samsung/dev-i2c6.c ? ? ? ? | ? 24 ++++++++----------------
> ?arch/arm/plat-samsung/dev-i2c7.c ? ? ? ? | ? 24 ++++++++----------------
> ?arch/arm/plat-samsung/include/plat/iic.h | ? ?2 ++
> ?9 files changed, 64 insertions(+), 120 deletions(-)
>
> --
> 1.7.2.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>



-- 
Shine bright,
(: Nav :)
