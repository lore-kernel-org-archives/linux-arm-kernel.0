From: horms@verge.net.au (Simon Horman)
Date: Thu, 18 Apr 2013 22:51:31 +0900
Subject: [PATCH v5 2/3] ARM: shmobile: kzm9g-reference: add AS3711 and
 CPUFreq DT bindings
In-Reply-To: <1365156038-12467-3-git-send-email-g.liakhovetski@gmx.de>
References: <1365156038-12467-1-git-send-email-g.liakhovetski@gmx.de>
 <1365156038-12467-3-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <20130418135131.GK20929@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 05, 2013 at 12:00:37PM +0200, Guennadi Liakhovetski wrote:
> This adds DT bindings for an AS3711 PMIC, used for supplying power to the
> CPU, some peripherals and the backlight, as well as extends the cpu0 DT
> node with OPPs and a reference to the PMIC to support the CPUFreq and
> CPU DVFS functions.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
> 
> v5: make the sd1 regulator immediately suitable for CPUFreq instead of
> postponing it to an incremental patch.
> 
>  arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |   86 ++++++++++++++++++++++++++
>  1 files changed, 86 insertions(+), 0 deletions(-)

Thanks, queued-up for v3.11 in the boards-kzm9g branch.
