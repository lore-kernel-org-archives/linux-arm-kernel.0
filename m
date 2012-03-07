From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 07 Mar 2012 13:51:01 -0700
Subject: [RESEND PATCH 0/3] arm: tegra: dts: USB Updates for Tegra legacy
 mode / OTG
In-Reply-To: <1331096674-8324-1-git-send-email-sjg@chromium.org>
References: <1331096674-8324-1-git-send-email-sjg@chromium.org>
Message-ID: <4F57CA35.50406@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/2012 10:04 PM, Simon Glass wrote:
> This little series brings in some bindings that seem useful for U-Boot.
> 
> I am working mostly in U-Boot, but since there is no shared .dts repo
> I was asked to commit these changes to the kernel. I do not propose to
> update the Linux USB drivers to match.
> 
> 
> Simon Glass (3):
>   arm: tegra: dts: Support host/device selection and legacy mode
>   arm: tegra: dts: Add legacy mode support to Tegra2x USB1 port
>   arm: tegra: dts: Mark USB1 as an OTG port on Seaboard

I ack'd this before, but just in case it got lost: The series,

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
