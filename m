From: robh@kernel.org (Rob Herring)
Date: Thu, 3 Aug 2017 11:06:56 -0500
Subject: [PATCH v5 1/4] dt-bindings: arm: Add entry for Beckhoff CX9020
In-Reply-To: <20170726120534.5516-2-linux-kernel-dev@beckhoff.com>
References: <20170726120534.5516-1-linux-kernel-dev@beckhoff.com>
 <20170726120534.5516-2-linux-kernel-dev@beckhoff.com>
Message-ID: <20170803160656.2l6nyvm7dglgaj34@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 26, 2017 at 02:05:31PM +0200, linux-kernel-dev at beckhoff.com wrote:
> From: Patrick Bruenn <p.bruenn@beckhoff.com>
> 
> - add vendor prefix bhf for Beckhoff
> - add new board binding bhf,cx9020
> 
> Signed-off-by: Patrick Bruenn <p.bruenn@beckhoff.com>
> ---
>  Documentation/devicetree/bindings/arm/bhf.txt         | 6 ++++++
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  MAINTAINERS                                           | 5 +++++
>  3 files changed, 12 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/bhf.txt

Acked-by: Rob Herring <robh@kernel.org>
