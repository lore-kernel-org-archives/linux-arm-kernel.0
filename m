From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 17 Mar 2016 14:04:30 +0000
Subject: [PATCH v2] ARM: rockchip: Fix use of plain integer as NULL pointer
In-Reply-To: <3852103.Khn1BuqerF@diego>
References: <1458222191-26023-1-git-send-email-peter.griffin@linaro.org>
 <3852103.Khn1BuqerF@diego>
Message-ID: <20160317140430.GA26606@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On Thu, 17 Mar 2016, Heiko St?bner wrote:

> Hi Peter,
> 
> no need to resend for that (will be lost when applying anyway), but for future 
> patches please consider the things below:
> 
> Am Donnerstag, 17. M?rz 2016, 13:43:11 schrieb Peter Griffin:
> > This fixes the following sparse build warning:
> > 
> >      mach-rockchip/platsmp.c:68:43: Using plain integer as NULL pointer
> > 
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> 
> please bring aling tags received in previous versions to future ones, like the 
> one from Lee:
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>

Will do, I didn't notice Lee had also Acked it. I should have been paying more
attention and not re-spinning whilst in a conf call.
> 
> > ---
> 
> changes in v2:
> - beautify commit message
> 
> 
> otherwise, patch looks nice and I'll pick it up shortly
> 
> 
> Thanks for catching this

No problem, thanks for the feedback and taking the patch.

regards,

Peter.
