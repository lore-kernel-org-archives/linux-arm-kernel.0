From: robh@kernel.org (Rob Herring)
Date: Mon, 8 Feb 2016 10:11:31 -0600
Subject: [PATCH 1/3] ARM: keystone: Create new binding for K2G SoC
In-Reply-To: <1454455517-7360-2-git-send-email-fcooper@ti.com>
References: <1454455517-7360-1-git-send-email-fcooper@ti.com>
 <1454455517-7360-2-git-send-email-fcooper@ti.com>
Message-ID: <20160208161131.GA20324@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2016 at 05:25:15PM -0600, Franklin S Cooper Jr wrote:
> From: Nishanth Menon <nm@ti.com>
> 
> K2G SoC family is the newest version of the Keystone family of processors.
> 
> The technical reference manual for K2G can be found here:
> http://www.ti.com/lit/ug/spruhy8/spruhy8.pdf
> 
> Add new bindings for K2G and the K2G evm. Also document these new bindings.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
>  Documentation/devicetree/bindings/arm/keystone/keystone.txt | 5 +++++
>  arch/arm/mach-keystone/keystone.c                           | 1 +
>  2 files changed, 6 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
