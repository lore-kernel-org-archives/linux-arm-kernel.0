From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 2 Jun 2011 18:44:54 +0900
Subject: [PATCH 4/5] ARM: S3C6410: Support 800MHz operation in cpufreq
In-Reply-To: <039601cc2109$319c9770$94d5c650$@com>
References: <20110601094313.GA23122@opensource.wolfsonmicro.com>
	<1306921493-30911-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1306921493-30911-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<037201cc2046$f5cc53b0$e164fb10$@com>
	<20110601104042.GA15387@opensource.wolfsonmicro.com>
	<038c01cc20b9$a55a5120$f00ef360$@com>
	<20110602082830.GA3085@opensource.wolfsonmicro.com>
	<039601cc2109$319c9770$94d5c650$@com>
Message-ID: <BANLkTimC=MrmjinzufrnOMSAgiQvVKdWhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 2, 2011 at 6:41 PM, Sangbeom Kim <sbkim73@samsung.com> wrote:
> On Wed, Jun 2, 2011 at 9:11 AM, Mark Brown
>>
>> It's really unfortunate that there's no software visible method I'm
>> aware of :/
> Unfortunately, There is no method to detect 800Mhz s3c6410 by software.

Then how about to introduce the software flags. and set it at each
board. It can support the 800MHz.
Also this flags are handled at cpufreq drivers properly.

How do you think?

>
>
>> I'm not sure it's a particular concern for the 800MHz part above others
>> simply because it's such a universal issue.
> Because Voltage margin(VDD_ARM) of s3c6410 800Mhz is particularly weak.
> Under 667Mhz, There is no issue for dvfs.
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
