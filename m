From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 20 Jun 2014 16:58:10 -0400
Subject: [PATCH 1/2] dt-binding: add vendor prefix for SolidRun
In-Reply-To: <1401140009-31505-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1401140009-31505-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20140620205810.GO21711@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 26, 2014 at 11:33:28PM +0200, Sebastian Hesselbarth wrote:
> SolidRun is a company from Israel producing small-sized home-media
> computers like the Marvell Dove based CuBox and Freescale IMX based
> CuBox-i. Document the missing vendor prefix.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: devicetree at vger.kernel.org
> Cc: linux-doc at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied to mvebu/dt with Rob's Ack.

v2 of patch 2/2 also applied to mvebu/dt.

thx,

Jason.
