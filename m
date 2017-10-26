From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 26 Oct 2017 16:00:44 +0800
Subject: [PATCH v2 0/2] Add HiSilicon INNO USB2 PHY driver support
In-Reply-To: <1508758512-22900-1-git-send-email-shawnguo@kernel.org>
References: <1508758512-22900-1-git-send-email-shawnguo@kernel.org>
Message-ID: <20171026080043.GA31354@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

On Mon, Oct 23, 2017 at 07:35:10PM +0800, Shawn Guo wrote:
> From: Shawn Guo <shawn.guo@linaro.org>
> 
> It adds device tree bindings and driver support for HiSilicon INNO USB2
> PHY device, which can be found on HiSilicon STB SoC Hi3798cv200.
> 
> Changes for v2:
>  - Move DT bindings into a separate patch.
>  - Rename hisi_inno_phy_start() to hisi_inno_phy_init() for aligning
>    name with .init hook.

Just let you know, we will have v3 of this series moving phy device to
be child node of peripheral controller syscon, just like what combphy v3
does.

Shawn
