From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 15 Jan 2015 10:28:50 -0700
Subject: [PATCH v2 06/11] ARM: tegra: Move out nyan-generic parts out
 from the nyan-big DT
In-Reply-To: <1421338359-27467-7-git-send-email-tomeu.vizoso@collabora.com>
References: <1421338359-27467-1-git-send-email-tomeu.vizoso@collabora.com>
 <1421338359-27467-7-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <54B7F8D2.4040400@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/15/2015 09:12 AM, Tomeu Vizoso wrote:
> In preparation for adding the DT for the nyan-blaze board.

"git format-patch -C" might help here; hopefully it'd highlight that 
arch/arm/boot/dts/tegra124-nyan.dtsi was a copy from 
arch/arm/boot/dts/tegra124-nyan-big.dts, with just a few small diffs?
