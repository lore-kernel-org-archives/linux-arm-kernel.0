From: sbkim73@samsung.com (Sangbeom Kim)
Date: Thu, 02 Jun 2011 18:41:05 +0900
Subject: [PATCH 4/5] ARM: S3C6410: Support 800MHz operation in cpufreq
In-Reply-To: <20110602082830.GA3085@opensource.wolfsonmicro.com>
References: <20110601094313.GA23122@opensource.wolfsonmicro.com>
	<1306921493-30911-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1306921493-30911-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<037201cc2046$f5cc53b0$e164fb10$@com>
	<20110601104042.GA15387@opensource.wolfsonmicro.com>
	<038c01cc20b9$a55a5120$f00ef360$@com>
	<20110602082830.GA3085@opensource.wolfsonmicro.com>
Message-ID: <039601cc2109$319c9770$94d5c650$@com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 2, 2011 at 9:11 AM, Mark Brown
> 
> It's really unfortunate that there's no software visible method I'm
> aware of :/
Unfortunately, There is no method to detect 800Mhz s3c6410 by software.


> I'm not sure it's a particular concern for the 800MHz part above others
> simply because it's such a universal issue.
Because Voltage margin(VDD_ARM) of s3c6410 800Mhz is particularly weak.
Under 667Mhz, There is no issue for dvfs. 
