From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 30 Jun 2014 14:32:08 -0600
Subject: [PATCH v2 1/4] of: Add NVIDIA Tegra Legacy Interrupt Controller
 binding
In-Reply-To: <1403917351-13215-1-git-send-email-thierry.reding@gmail.com>
References: <1403917351-13215-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <53B1C948.6050603@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2014 07:02 PM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The Legacy Interrupt Controller found on NVIDIA Tegra SoCs is used by
> the AVP coprocessor and can also serve as a backup for the ARM Cortex
> CPU's local interrupt controller (GIC).
> 
> The LIC is subdivided into multiple identical units, each handling 32
> possible interrupt sources.

The series looks OK to me, although I guess there will be a V3 to
address Mark's comments?
