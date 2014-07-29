From: tj@kernel.org (Tejun Heo)
Date: Tue, 29 Jul 2014 10:34:38 -0400
Subject: [PATCH v12 4/8] ata: libahci: allow to use multiple PHYs
In-Reply-To: <1406618447-25499-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1406618447-25499-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20140729143438.GB4791@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 09:20:47AM +0200, Antoine T?nart wrote:
> The current implementation of the libahci does not allow to use multiple
> PHYs. This patch adds the support of multiple PHYs by the libahci while
> keeping the old bindings valid for device tree compatibility.
> 
> This introduce a new way of defining SATA ports in the device tree, with
> one port per sub-node. This as the advantage of allowing a per port
> configuration. Because some ports may be accessible but disabled in the
> device tree, the port_map mask is computed automatically when using
> this.
> 
> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> Acked-by: Hans de Goede <hdegoede@redhat.com>

Patch doesn't apply to libata/for-3.17.  Please refresh.

Thanks.

-- 
tejun
