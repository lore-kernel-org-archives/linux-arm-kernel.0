From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Thu, 9 Jan 2014 16:33:59 +0530
Subject: [PATCH] ARM: config: enable ams AS3722 power reset driver
In-Reply-To: <52CDA181.4030005@wwwdotorg.org>
References: <1389084000-17033-1-git-send-email-ldewangan@nvidia.com>
 <52CDA181.4030005@wwwdotorg.org>
Message-ID: <52CE821F.6030908@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 09 January 2014 12:35 AM, Stephen Warren wrote:
> On 01/07/2014 01:39 AM, Laxman Dewangan wrote:
>> ams AS3722 is used as system PMIC for Tegra124 based Venice2.
>> Enable ams AS3722 power reset driver for enabling power off
>> system using PMIC.
> I assume you'll also send a patch to add the following to DT:
>
> 			ams,system-power-controller;
>
Oops, I missed it.
Sent it.
