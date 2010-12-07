From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 7 Dec 2010 10:16:31 +0000
Subject: [PATCH v2 1/3] ARM: omap: Enable low-level omap3 PM code to work
	withCONFIG_THUMB2_KERNEL
In-Reply-To: <8ff74b57e40b64459978eefba8f4c9ca@mail.gmail.com>
References: <1291656937-24992-1-git-send-email-dave.martin@linaro.org>
	<1291656937-24992-2-git-send-email-dave.martin@linaro.org>
	<8ff74b57e40b64459978eefba8f4c9ca@mail.gmail.com>
Message-ID: <AANLkTikOSb5-wBSy_ZANVsHga7XmWPrwP=0Xs0eGOxb5@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 7, 2010 at 6:31 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> Dave,
>> -----Original Message-----
>> From: linaro-dev-bounces at lists.linaro.org [mailto:linaro-dev-
>> bounces at lists.linaro.org] On Behalf Of Dave Martin
>> Sent: Monday, December 06, 2010 11:06 PM
>> To: linux-arm-kernel at lists.infradead.org
>> Cc: Tony Lindgren; Dave Martin; linux-omap at vger.kernel.org; linaro-
>> dev at lists.linaro.org
>> Subject: [PATCH v2 1/3] ARM: omap: Enable low-level omap3 PM code to
> work
>> withCONFIG_THUMB2_KERNEL
>>

[...]

>
> No need to mention but this patch changes lot of things around
> power management code. You said " Tested on: omap3 (Beagle xM A2)"
>
> What did you test ? Is it just boot test ? For sure just boot
> test is not enough for this patch and needs to test the PM.

That's a fair point--- yes, I've only tested boot / reboot / shutdown so far.

If you have any thoughts about how to excercise the power management
functionality more completely, I'd be happy to have a go...

Cheers
---Dave
