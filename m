From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 23 Apr 2014 10:13:32 -0600
Subject: [PATCH] ARM: dts: ventana: Add HDMI support
In-Reply-To: <1398239271-12570-1-git-send-email-tharvey@gateworks.com>
References: <1398239271-12570-1-git-send-email-tharvey@gateworks.com>
Message-ID: <5357E6AC.3070909@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/23/2014 01:47 AM, Tim Harvey wrote:
> Configure ddc and enable HDMI

It would be nice if the patch subject included the SoC name rather than
"dts":

ARM: imx: add HDMI support for Ventana
or:
ARM: dts: imx: add HDMI support for Ventana

There's a Ventana board for both i.MX and Tegra, so this patch caught my
eye.
