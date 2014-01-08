From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 08 Jan 2014 12:05:37 -0700
Subject: [PATCH] ARM: config: enable ams AS3722 power reset driver
In-Reply-To: <1389084000-17033-1-git-send-email-ldewangan@nvidia.com>
References: <1389084000-17033-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <52CDA181.4030005@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/07/2014 01:39 AM, Laxman Dewangan wrote:
> ams AS3722 is used as system PMIC for Tegra124 based Venice2.
> Enable ams AS3722 power reset driver for enabling power off
> system using PMIC.

I assume you'll also send a patch to add the following to DT:

			ams,system-power-controller;
