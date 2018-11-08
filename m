From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 8 Nov 2018 09:36:17 +0000
Subject: [PATCH v2 2/9] arm64: defconfig: Drop ARM_BIG_LITTLE_CPUFREQ
In-Reply-To: <03f41ca8-68c6-f075-cb1e-c7f630a3b128@free.fr>
References: <898e79a6-092c-d013-d2bb-f6260e761379@free.fr>
 <03f41ca8-68c6-f075-cb1e-c7f630a3b128@free.fr>
Message-ID: <20181108093617.GB8433@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2018 at 11:39:42PM +0100, Marc Gonzalez wrote:
> Commit a7314405d83c ("drop ARM_BIG_LITTLE_CPUFREQ support for ARM64")
> dropped ARM_BIG_LITTLE_CPUFREQ support for ARM64.
>

Looks good,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

But I left it intentionally to avoid churn assuming it will go away when
ARM SoC team runs savedefconfig and sync the defconfig.

--
Regards,
Sudeep
