From: josh.wu@atmel.com (Josh Wu)
Date: Thu, 22 Aug 2013 18:02:59 +0800
Subject: [PATCH v2 4/4] iio: at91: introduce touch screen support in iio
 adc driver
In-Reply-To: <520CAD07.1080709@kernel.org>
References: <1376219071-29946-1-git-send-email-josh.wu@atmel.com>
 <1376219071-29946-5-git-send-email-josh.wu@atmel.com>
 <20130812172453.GB31418@core.coreip.homeip.net> <520CAD07.1080709@kernel.org>
Message-ID: <5215E1D3.5090905@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Jonathan

On 8/15/2013 6:27 PM, Jonathan Cameron wrote:
>
> On 08/12/13 18:24, Dmitry Torokhov wrote:
>> Hi Josh,
> Hi Dmitry,
>
> As you haven't raised it here, I am guessing you are fine with having this
> chunk of input related code in an IIO driver?  I wonder if it would be
> better to break this into an mfd core and child input and iio drivers.
> The two parts look fairly separable to me.
> Clearly that means adding some overhead, but the gain is that the input
> code ends up in input and the IIO code in IIO.
>
> What are your views on this?  I'm fairly flexible if you think it simply
> isn't worth the hassle of breaking this up.  I'm more worried about setting
> a precident than anything else.
>
> Jonathan

Since Dmitry has no feedback yet. I am not sure is it a right time to 
send out the next version for the IIO ad91 touch patch?

[snip...]

Best Regards,
Josh Wu
