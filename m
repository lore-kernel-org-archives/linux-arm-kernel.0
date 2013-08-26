From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 26 Aug 2013 13:54:59 +0200
Subject: [RFC] cleanup mach-s5p*
In-Reply-To: <1f7b01cea1f6$9560aa10$c021fe30$%kim@samsung.com>
References: <1f7b01cea1f6$9560aa10$c021fe30$%kim@samsung.com>
Message-ID: <521B4213.8040601@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On 8/26/2013 2:52 AM, Kukjin Kim wrote:
> Hi all,
>
> I have a plan to remove supporting following SoCs in mainline in the near
> future.
> - s5pc100 - smdkc100
> - s5pv210(s5c110) - aquial, goni, smdkc110, smdkv210, torbreck
> - s5p64x0(s5p6440, s5p6450)- smdk6440, smdk6450
>
> I think users don't seem to use that any more with mainline. If so, we are
> able to consider, it is not right now though.
>
> How do you think?

I am against removing support for S5PC110/S5PV210. We still use it for some
of our internal development. DT support patches will be posted soon (pinctrl
and clocks). Support for S5PC100 can be easily added the same way (we also
have DT patches almost ready). S5PV210, S5PC100 and the older S3C64xx can
all be handled by the same Samsung-DT 'machine file'.

However we don't have any s5p64x0 based boards to develop DT support for
them.

Best regards
-- 
Marek Szyprowski
Samsung R&D Institute Poland
