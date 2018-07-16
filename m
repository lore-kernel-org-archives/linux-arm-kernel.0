From: robh@kernel.org (Rob Herring)
Date: Mon, 16 Jul 2018 09:20:27 -0600
Subject: [PATCH v6 2/5] dt-bindings: clock: Add S700 support for Actions
 Semi Soc's
In-Reply-To: <20180715203524.11948-3-sravanhome@gmail.com>
References: <20180715203524.11948-1-sravanhome@gmail.com>
 <20180715203524.11948-3-sravanhome@gmail.com>
Message-ID: <20180716152027.GA28696@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 15, 2018 at 10:35:21PM +0200, Saravanan Sekar wrote:
> Add clock bindings constants for action S700
> Maintain common clock dt-bindings for Actions Semi SoC's
> S700 and S900.
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  ...tions,s900-cmu.txt => actions,owl-cmu.txt} |  20 +--
>  include/dt-bindings/clock/actions,s700-cmu.h  | 118 ++++++++++++++++++
>  2 files changed, 129 insertions(+), 9 deletions(-)
>  rename Documentation/devicetree/bindings/clock/{actions,s900-cmu.txt => actions,owl-cmu.txt} (68%)
>  create mode 100644 include/dt-bindings/clock/actions,s700-cmu.h

Reviewed-by: Rob Herring <robh@kernel.org>
