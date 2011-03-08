From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 09 Mar 2011 07:44:08 +0900
Subject: [PATCH 1/3] This patch adds support HR-Timer(High Resolution
	Timer) and dynamic tick system for S5P SoCs. There are many
	clock	sources for
	HR-Timer on S5P SoCs. The PWM timer, RTC, System Timer,
	and MCT can be used for clock source. This patch can onl
In-Reply-To: <20110308094955.GB25874@n2100.arm.linux.org.uk>
References: <1299456554-15280-1-git-send-email-sbkim73@samsung.com>
	<1299456554-15280-2-git-send-email-sbkim73@samsung.com>
	<20110308094955.GB25874@n2100.arm.linux.org.uk>
Message-ID: <041801cbdde2$5927d080$0b777180$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> 
> > Subject: [PATCH 1/3] This patch adds support HR-Timer(High Resolution Timer)
>         and dynamic tick system for S5P SoCs. There are many clock
>         sources for HR-Timer on S5P SoCs. The PWM timer, RTC, System Timer,
>         and MCT can be used for clock source. This patch can only support PWM
>         timer for clocksource of S5P64x0 and S5PV210.
> 
> Please don't fill the subject line with the entire patch description.
> Subject lines are always supposed to be a brief summary of the message
> being sent, or with patches a brief summary of what the patch is about.
> 
> Put the rest of the patch description in the body of the message.
> 
> Don't say things like "This patch adds", "Adding support for", etc.  When
> the patch has been merged, years later it doesn't make sense to read such
> patch descriptions.
> 
> "S5P: Common HRT and NO_HZ support" is sufficient to summarise the patch.
> 
> Note that some mail clients only show you the first 40 or so characters of
> the subject line in their message index.  To illustrate:
> 
> 6472 N   Mar 07 Sangbeom Kim    (  19) [PATCH V3 0/3] ARM: S5P: Add HRT
> support
> 6473     Mar 07 Sangbeom Kim    ( 530) ??>[PATCH 1/3] This patch adds support
> HR
> 6474 N   Mar 07 Sangbeom Kim    ( 208) ??>[PATCH 2/3] This patch modify
> s5pv210_
> 6475 N   Mar 07 Sangbeom Kim    ( 112) ??>[PATCH 3/3] This patch update mach-
> s5p
> 
> So to have half the subject space wasted by "This patch modify" is not
> very productive.

Hmm...Sangbeom,

Absolutely, I agree with Russell's opinions.
According to your previous patch, maybe you made a mistake :(

And should be changed PWM Timer for HRT on SMDKV210, because PWM Timer3 is already used for backlight.

Please re-submit it, rc8 already released. I think you know the meaning ;)

Russell,
Thanks for your pointing out and I will think again about the patch subjects of Samsung stuff before applying.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
