From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 22 Sep 2017 11:23:27 +0200
Subject: [PATCH v2 0/8] ARM: dts: rockchip: add Utgard Mali nodes for some
 socs
In-Reply-To: <20170915091812.13368-1-heiko@sntech.de>
References: <20170915091812.13368-1-heiko@sntech.de>
Message-ID: <3670729.UWqOD6MBPG@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 15. September 2017, 11:18:04 CEST schrieb Heiko Stuebner:
> This adds a mali-supply similar to the Midgard binding, the
> compatibles for 3 Rockchip socs and the nodes for these.
> 
> The rk3036 and rk3188 gpus were tested, on the boards that
> get their gpus enabled, using the current Lima resurrection
> project and were able to probe the gpus sucessfully and draw
> a nice red-triangle in an off-screen application.
> 
> The only special thing Rockchip Malis do, is that all MMUs have
> a shared interrupt and all PPs also have a shared interrupt, but
> that works out well with the current binding.

applied all 8 for 4.15 with Rob's Acks for the binding changes.
