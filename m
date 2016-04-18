From: robh@kernel.org (Rob Herring)
Date: Mon, 18 Apr 2016 12:19:27 -0500
Subject: [PATCH 2/2] ARM: i.MX35 clk: Introduce DT include for clock
 provider
In-Reply-To: <1460669450-11729-2-git-send-email-akurz@blala.de>
References: <1460669450-11729-1-git-send-email-akurz@blala.de>
 <1460669450-11729-2-git-send-email-akurz@blala.de>
Message-ID: <20160418171927.GA26734@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2016 at 11:30:50PM +0200, Alexander Kurz wrote:
> Use clock defines in order to make devicetrees more human readable
> 
> Signed-off-by: Alexander Kurz <akurz@blala.de>
> ---
>  .../devicetree/bindings/clock/imx35-clock.txt      |  93 +----

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/clk/imx/clk-imx35.c                        | 429 ++++++++++++---------
>  include/dt-bindings/clock/imx35-clock.h            |  98 +++++
>  3 files changed, 349 insertions(+), 271 deletions(-)
>  create mode 100644 include/dt-bindings/clock/imx35-clock.h
