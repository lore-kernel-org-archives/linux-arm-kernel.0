From: rajeshwari.birje@gmail.com (Rajeshwari Birje)
Date: Thu, 21 Jul 2011 11:05:58 +0530
Subject: [PATCH 0/3] ARM: Add SDMMC support for S5P64X0
In-Reply-To: <003601cc4746$61b27570$25176050$%kim@samsung.com>
References: <1308571049-4412-1-git-send-email-rajeshwari.s@samsung.com>
	<003601cc4746$61b27570$25176050$%kim@samsung.com>
Message-ID: <CAPs=JDeU5w_4iuvGyF8bad6tNO4HQpunsbS8_oFhi+oLb5TK0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin Kim,

Currently working on updating the SDMMC patches.
Working on rebasing the SDMMC patches for the Clkdev support.
Will update the same and send the patches for review.

Regards,
Rajeshwari Shinde.


On Thu, Jul 21, 2011 at 7:04 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Rajeshwari Shinde wrote:
>>
>> From: rajeshwari.s <rajeshwari.s@samsung.com>
>>
>> S5P64X0 supports 3 Channel MMC/SDHC/SDIO.
>>
>> This patchset adds the setup files, gpio configs and enables the HSMMC
> device
>> for S5P64X0.
>>
>> ?o To Kukjin Kim and Sangbeom Kim
>> [PATCH 1/3] ARM: S5P64X0: Add HSMMC setup for host Controller
>> [PATCH 2/3] ARM: S5P64X0: Initialize default SDHCI devices and platform
> data
>> [PATCH 3/3] ARM: S5P64X0: Enable SDHCI support
>> ---
>
> As I know, I got your reply on my comments like following.
>
> --
> Hi Kukjin Kim,
>
> Thank you for your comments.
> Will modify the patches as per comments and resend the same.
>
> Regards,
> Rajeshwari Shinde.
> --
> Hi Russell,
>
> Thank you for the comment will do the change as specified.
>
> Regards,
> Rajeshwari Shinde.
> --
>
> But I didn't get any updated patch and unfortunately, we don't have much
> time for upcoming merge window.
>
> One more, please don't use html type e-mail in mailing list.
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
