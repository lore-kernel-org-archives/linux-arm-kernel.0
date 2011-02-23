From: yong.shen@linaro.org (Yong Shen)
Date: Wed, 23 Feb 2011 15:41:58 -0000
Subject: [PATCH v3 1/2] ARM: IMX5: cpuidle driver
In-Reply-To: <AANLkTi=VkaCY5u-ibEKWU6=AiRkB5aZwPevY6A3bmk0T@mail.gmail.com>
References: <1297416973-32740-1-git-send-email-yong.shen@linaro.org>
	<1297416973-32740-2-git-send-email-yong.shen@linaro.org>
	<20110215182752.GD2027@pengutronix.de>
	<AANLkTim_7HiWutTyTuWvAR5sx1Nd7HdSyhfwRjS2CfYg@mail.gmail.com>
	<20110217105415.GB24426@pengutronix.de>
	<AANLkTi=VkaCY5u-ibEKWU6=AiRkB5aZwPevY6A3bmk0T@mail.gmail.com>
Message-ID: <AANLkTi=DSKxwGoMM8Og7X6LFZewhDNrAT-LBo1TOy0wp@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

I noticed there were no comments for v3, but you had comments for v2 which
was posted after v3. See below:

>>I see. Maybe we should make this a platform driver then like for example
>>davinci does.

>I had sent out v3 patch before the your last comments.
>I noticed how davinci is doing, but some SOCs like omap, they also do it in
another way like my code.
>However, if you prefer the way davinci is doing, I will redo it. Please
confirm

Shall we still follow davinci's code?

Thanks
Yong
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110223/510859b3/attachment-0001.html>
