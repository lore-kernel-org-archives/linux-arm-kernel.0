From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 06 Oct 2016 19:05:26 +0200
Subject: [PATCH 1/3] ARM: dts: rockchip: Enable build of rk3066 MK808 dts
In-Reply-To: <c6d58e9b-8d36-61c5-5af1-59b1c293d969@gmail.com>
References: <cover.1475764778.git.paweljarosz3691@gmail.com>
 <46121446.zsYkG9qnut@phil> <c6d58e9b-8d36-61c5-5af1-59b1c293d969@gmail.com>
Message-ID: <2552415.D3JWyKI0Mg@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 6. Oktober 2016, 19:05:15 CEST schrieb Pawe? Jarosz:
> Hi Heiko
> 
> > This patch breaks bisectability, as it adds a dtb to the makefile that you
> > only add in patch3 which makes builds fail. Please fold your patches 1
> > and 3 into one patch and also add and entry to
> > Documentation/devicetree/bindings/arm/ rockchip.txt for the board.
> > 
> > 
> > Heiko
> 
> Should i squash all patches in one?
> 
> I saw now in logs that it's common practise.

Nope ... vendor-prefix should stay separate, everything else can be in one 
patch.
