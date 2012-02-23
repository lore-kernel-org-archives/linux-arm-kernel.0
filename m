From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 23 Feb 2012 19:15:08 +0530
Subject: [PATCH 1/6] arm: omap4: suspend: Program all domains to RET
In-Reply-To: <1330003320-17400-2-git-send-email-t-kristo@ti.com>
References: <1330003320-17400-1-git-send-email-t-kristo@ti.com>
 <1330003320-17400-2-git-send-email-t-kristo@ti.com>
Message-ID: <CAMQu2gwdKXgjr=s7o8Wx_tM6_RKan3VoqPdnVULm8JvDTjJj2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 6:51 PM, Tero Kristo <t-kristo@ti.com> wrote:
> From: Rajendra Nayak <rnayak@ti.com>
>
> Remove the FIXME's in the suspend sequence since
> we now intend to support system level RET support.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---

$subject
arm: omap4: suspend: Program all domains to RET
s/arm/ARM
s/omap4/OMAP4
s/RET/retention

o.w looks good.
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
