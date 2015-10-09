From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 09 Oct 2015 17:09:38 +0200
Subject: [GIT PULL 1/2] Rockchip drivers for 4.4
In-Reply-To: <160496219.B4xWx83NpX@phil>
References: <160496219.B4xWx83NpX@phil>
Message-ID: <8691740.7EoGdKhH7X@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 October 2015 02:34:44 Heiko Stuebner wrote:
> Add the power-domain base-driver which currently contains
> support for the rk3288 powerdomain layout but can be easily
> extended for the socs (including arm64) later on.
> A big thanks to Ceasar Wang for pulling through on this
> during 18 revisions.
> Also included is a fix to the pm-clock handling in the generic
> powerdomains to adapt it to the per-user clock handling we now
> do, Acked by Rafael Wysocki.
> 

Merged into next/driver, thanks!

	Arnd
