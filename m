From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 24 Nov 2015 13:31:29 -0700
Subject: [PATCH 1/4] ARM: dts: vf610: relicense vf???.dtsi under GPLv2/X11
In-Reply-To: <1448323069-23208-2-git-send-email-stefan@agner.ch>
References: <1448323069-23208-1-git-send-email-stefan@agner.ch>
 <1448323069-23208-2-git-send-email-stefan@agner.ch>
Message-ID: <5654C921.4090707@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/23/2015 04:57 PM, Stefan Agner wrote:
> GPLv2-only devicetrees make reuse difficult for software components
> licensed under a different license.
>
> The consensus is that a GPL/X11 dual-license should allow all necessary
> uses, so relicense the vfxxx.dtsi, vf500.dtsi and vf610.dtsi files to
> this combination.
>
> CCs were acquired using (updated some email addresses):
> git shortlog -sne --no-merges arch/arm/boot/dts/vf???.dtsi

Acked-by: Stephen Warren <swarren@nvidia.com>
