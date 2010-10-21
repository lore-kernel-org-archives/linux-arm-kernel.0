From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 21 Oct 2010 12:54:56 +0900
Subject: [PATCH 5/5] ARM: SAMSUNG: Add to enable/disable clock on S3C PL330
In-Reply-To: <030201cb70c8$bc7f4aa0$357ddfe0$%kim@samsung.com>
References: <1287622713-1657-1-git-send-email-kgene.kim@samsung.com>
	<1287622713-1657-6-git-send-email-kgene.kim@samsung.com>
	<AANLkTi=ZTBuPBDL4MZ7MPn3Ha_cNhyShosyzn8q6QF3N@mail.gmail.com>
	<030201cb70c8$bc7f4aa0$357ddfe0$%kim@samsung.com>
Message-ID: <AANLkTikQXkfCfimEzWGyiVRNPWA8UaQQ=d-s_hmXxX4u@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 21, 2010 at 11:36 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Kyungmin Park wrote:
>>
>> On Thu, Oct 21, 2010 at 9:58 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>> > From: Seungwhan Youn <sw.youn@samsung.com>
>> >
>> > This patch adds to enable/disable DMA operation clock on S3C-PL330
>> > DMA controller driver.
>>
>> The title and description seems to clock gating but actual code is
>> just enable at probe and disable at remove.
>>
>> Can you make it REAL clock gating, enable clock only when using?
>>
>
> This is just to move DMA enable/disable clock into DMA driver(S3C PL330).
> So it would be better if we could discuss about what you said next time.
>
> Basically, I prefer most clocks should be registered as disabled, then if
> required enable, just should be controlled in each driver.

And support clock & block gating basically at drivers.
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
