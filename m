From: robh@kernel.org (Rob Herring)
Date: Mon, 19 Feb 2018 08:34:31 -0600
Subject: [PATCH 1/4][v4] dt-bindings: mtd-physmap: Add endianness supports
In-Reply-To: <20180215114904.23627-1-prabhakar.kushwaha@nxp.com>
References: <20180215114904.23627-1-prabhakar.kushwaha@nxp.com>
Message-ID: <20180219143431.ulznksgjv6ng5e6p@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 15, 2018 at 05:19:04PM +0530, Prabhakar Kushwaha wrote:
> Connection between flash and controller is not necessary to be always
> of same type. It may varies from platform to platform.
> 
> Adding endianness (optional) property to provide connection type
> information.
> 
> Signed-off-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
> ---
> Changes for v2: updated subject
> Changes for v3: fixed typo for "big-endian"
> Changes for v4: Moved binding definition in mtd-physmap.txt
> as discussed at https://patchwork.ozlabs.org/patch/842543/
> 
>  Documentation/devicetree/bindings/mtd/mtd-physmap.txt | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
