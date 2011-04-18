From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 18 Apr 2011 10:44:13 -0700
Subject: [PATCH] ARM: allow hotplug on msm
In-Reply-To: <1301078861-1991-1-git-send-email-johlstei@codeaurora.org>
References: <1301078861-1991-1-git-send-email-johlstei@codeaurora.org>
Message-ID: <4DAC786D.4020809@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On 3/25/2011 11:47 AM, Jeff Ohlstein wrote:
> Hotplug support was added in 9f1890a (msm: hotplug: support cpu hotplug
> on msm, 2010-12-02)
>
> Signed-off-by: Jeff Ohlstein <johlstei@codeaurora.org>

This fixes a Kconfig warning on MSM:

warning: (PM_SLEEP_SMP) selects HOTPLUG_CPU which has unmet direct
dependencies (SMP && HOTPLUG && EXPERIMENTAL && !ARCH_MSM)

Is there any way we can get this merged for .39 final? It's 6863/1 in
the patch tracker.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
