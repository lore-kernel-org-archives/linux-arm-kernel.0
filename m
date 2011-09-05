From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 5 Sep 2011 15:46:55 +0530
Subject: [PATCH 0/6] Add device tree support for PL330 dma controller
	driver
In-Reply-To: <001a01cc6b8b$21708470$64518d50$%kim@samsung.com>
References: <1314348014-2481-1-git-send-email-thomas.abraham@linaro.org>
	<1314638947.1606.157.camel@vkoul-udesk3>
	<001a01cc6b8b$21708470$64518d50$%kim@samsung.com>
Message-ID: <CAJuYYwR65Y4V2S4Moz1rw=EJV44kky96K+Dqd7VwP_JvK9YDsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mr. Kim,

On 5 September 2011 10:47, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Vinod Koul wrote:
>>
>> On Fri, 2011-08-26 at 14:10 +0530, Thomas Abraham wrote:
>> > This patchset adds device tree support for PL330 driver and uses it
>> > to add device tree support for Samsung platforms, specifically Exynos4.
>> The DMA patches looks good to me. Do you want this to go thru slave-dma
>> tree or somewhere else.
>> I will need acks on 3, 5 and 6th patch to carry them.
>>
>
> Looks good to me on 3 and 5th patch, I think, 6th patch is needed to update, please refer to my comments on there.
>
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
>
> As you know, Boojin Kim submitted 8th patch last Friday. So would be nice to me if you could rebase Thomas' patch based on her updated patch set and apply all series into your slave-dma.git samsung_dma branch I think it?s easy because v8 changes are small then I will merge it into my -next to prevent useless conflicts.
>

I will test the pl330 device tree patches with Boonjin's pl330 driver
update patches and resubmit if there are any changes. Thank you for
your ack.

Thanks,
Thomas.

> If any problems, please let me know.
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
>
