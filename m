From: horms@verge.net.au (Simon Horman)
Date: Thu, 6 Sep 2018 10:56:37 +0200
Subject: [PATCH 05/21] ARM: shmobile: use for_each_of_cpu_node iterator
In-Reply-To: <20180905193738.19325-6-robh@kernel.org>
References: <20180905193738.19325-1-robh@kernel.org>
 <20180905193738.19325-6-robh@kernel.org>
Message-ID: <20180906085637.h7ae46qqdjti5g7q@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2018 at 02:37:22PM -0500, Rob Herring wrote:
> Use the for_each_of_cpu_node iterator to iterate over cpu nodes. This
> has the side effect of defaulting to iterating using "cpu" node names in
> preference to the deprecated (for FDT) device_type == "cpu".
> 
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-renesas-soc at vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
