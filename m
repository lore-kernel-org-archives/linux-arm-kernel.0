From: robh@kernel.org (Rob Herring)
Date: Mon, 31 Oct 2016 00:57:03 -0500
Subject: [PATCH v2 2/3] dt-bindings: reset: Add K2G reset definitions
In-Reply-To: <20161027214941.24641-3-afd@ti.com>
References: <20161027214941.24641-1-afd@ti.com>
 <20161027214941.24641-3-afd@ti.com>
Message-ID: <20161031055703.y55nqcoplfopspkd@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2016 at 04:49:40PM -0500, Andrew F. Davis wrote:
> Add identifiers for the K2G resets managed by the PMMC.
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  MAINTAINERS                     |  1 +
>  include/dt-bindings/reset/k2g.h | 22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+)
>  create mode 100644 include/dt-bindings/reset/k2g.h

This belongs with the previous patch. It is part of the binding 
definition.

Rob
