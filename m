From: robh@kernel.org (Rob Herring)
Date: Sat, 17 Nov 2018 09:43:28 -0600
Subject: [PATCH v2 1/4] dt-bindings: pinctrl: k3: Introduce pinmux
 definitions
In-Reply-To: <20181113060111.16374-2-vigneshr@ti.com>
References: <20181113060111.16374-1-vigneshr@ti.com>
 <20181113060111.16374-2-vigneshr@ti.com>
Message-ID: <20181117154328.GA4095@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Nov 2018 11:31:08 +0530, Vignesh R wrote:
> The dt-bindings header for TI K3 AM6 SoCs define a set of macros for
> defining pinmux configs in human readable form, instead of raw-coded
> hex values.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  MAINTAINERS                      |  1 +
>  include/dt-bindings/pinctrl/k3.h | 35 ++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
>  create mode 100644 include/dt-bindings/pinctrl/k3.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
