From: gbean@codeaurora.org (Gregory Bean)
Date: Wed, 01 Sep 2010 16:53:42 -0700
Subject: [PATCH] msm: Featurize gpiomux.
In-Reply-To: <1283384144.21049.26.camel@c-dwalke-linux.qualcomm.com>
References: <1283383572-15635-1-git-send-email-gbean@codeaurora.org>
	<1283384144.21049.26.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <4C7EE786.9040302@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Wed, 2010-09-01 at 16:26 -0700, Gregory Bean wrote:
>> Featurize gpiomux so that systems like 7x00 which do not wish to use it
>> do not have to be saddled with the configuration tables.
>>
>
> What happens without this?

Not much, until the gpiolib hooks come along (see my next two patches), 
and then everybody would be forced to have the gpiomux config table 
without the featurization.  And for those folks not using it, that's a 
big empty table full of annoying nothingness...

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
