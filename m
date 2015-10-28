From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 28 Oct 2015 18:31:13 +0900
Subject: [PATCH] MAINTAINERS: Start using the 'reviewer' (R) tag
In-Reply-To: <CABxcv=mGZstqyrkB95hjDCYCvhDJDVD=ga-Fg_5yPtXETuWe=g@mail.gmail.com>
References: <1445960557-24328-1-git-send-email-lee.jones@linaro.org>
 <20151027172428.GB21070@earth> <20151027181555.GE5828@x1>
 <1445971482.2757.27.camel@perches.com>
 <CAJKOXPc_w2Dc8LvkCu_d+kjZZmYScXboQrpNWdicT2yfL_5D7Q@mail.gmail.com>
 <20151028082446.GF5828@x1>
 <CABxcv=mGZstqyrkB95hjDCYCvhDJDVD=ga-Fg_5yPtXETuWe=g@mail.gmail.com>
Message-ID: <563095E1.9010406@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.10.2015 18:21, Javier Martinez Canillas wrote:
> Hello Lee,
> 

(...)
Let me only add something to certain part of your email...

>> But you aren't maintaining the driver i.e. you don't collect patches
>> and *maintain* them on an upstream branch.  Granted some of you guys
>> are doing a great job of maintaining branches on your downstream or
>> BSP kernels, but conduct a Reviewer type role for upstream.
>>
>> You guys are pushing back like this is some kind of demotion.  That's
>> not the case at all.  All it does is better describe the (very worthy)
>> function you *actually* provide.
>>
> 
> But I think it makes description less accurate in fact, since without
> $SUBJECT get_maintainers.pl reports for example:
> 
> Krzysztof Kozlowski <k.kozlowski@samsung.com> (supporter:MAXIM PMIC
> AND MUIC DRIVERS FOR EXYNOS BASED BO...)
> Lee Jones <lee.jones@linaro.org> (supporter:MULTIFUNCTION DEVICES (MFD))
> 
> and after the change:
> 
> Krzysztof Kozlowski <k.kozlowski@samsung.com> (reviewer)
> Lee Jones <lee.jones@linaro.org> (supporter:MULTIFUNCTION DEVICES (MFD))
> 
> He also works for Samsung so the driver is not only maintained but
> supported since he can actually take care of it as a part of his day
> job (if I understood correctly).

Oh, that's interesting semantic change. Yes, in that particular case, I
added the "supported" tag on purpose - it's part of my job. It is
connected with what I said in other reply - we have deep interest in
these drivers. Not only "I will review the code if I have the time". No.
I will devote my time to ensure that the code is working on our products.

Best regards,
Krzysztof
