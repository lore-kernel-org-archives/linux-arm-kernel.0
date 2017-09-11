From: horms@verge.net.au (Simon Horman)
Date: Mon, 11 Sep 2017 09:25:02 +0200
Subject: [PATCH v3] ARM: dts: r8a7743: Add IIC cores to dtsi
In-Reply-To: <1504705926-31625-1-git-send-email-chris.paterson2@renesas.com>
References: <1502704398-28378-1-git-send-email-biju.das@bp.renesas.com>
 <1504705926-31625-1-git-send-email-chris.paterson2@renesas.com>
Message-ID: <20170911072502.GA10251@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 06, 2017 at 02:52:06PM +0100, Chris Paterson wrote:
> From: Biju Das <biju.das@bp.renesas.com>
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> ---
> v2->v3
> - Renamed lables to use iic instead of i2c.
> 
> v1->v2
> - Corrected the resets property for i2c6 device node.
> 
> This patch is based on renesas-devel tag renesas-devel-20170905-v4.13.
> 
> DT bindings has been accepted by Wolfram:
> https://patchwork.kernel.org/patch/9888119

Thanks, applied.
