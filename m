From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 24 Nov 2015 14:02:21 +0800
Subject: [PATCH 3/4] ARM: dts: vf610-cosmic: relicense vf610-cosmic.dts
 under GPLv2/X11
In-Reply-To: <1448323291-23505-1-git-send-email-stefan@agner.ch>
References: <1448323291-23505-1-git-send-email-stefan@agner.ch>
Message-ID: <20151124060221.GH11999@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2015 at 04:01:31PM -0800, Stefan Agner wrote:
> GPLv2-only devicetrees make reuse difficult for software components
> licensed under a different license.
> 
> The consensus is that a GPL/X11 dual-license should allow all necessary
> uses, so relicense the vf610-twr.dts file to this combination.
> 
> CCs were acquired using (updated some email addresses):
> git shortlog -sne --no-merges arch/arm/boot/dts/vf610-cosmic.dts
> 
> CC: Cory Tusar <cory.tusar@pid1solutions.com>
> CC: Matt Porter <matt.porter@linaro.org>
> CC: Olof Johansson <olof@lixom.net>
> CC: Shawn Guo <shawnguo@kernel.org>

Acked-by: Shawn Guo <shawnguo@kernel.org>

> Signed-off-by: Stefan Agner <stefan@agner.ch>
