From: robh@kernel.org (Rob Herring)
Date: Thu, 17 Aug 2017 10:10:31 -0500
Subject: [PATCH v4 1/4] Documentation: devicetree: add binding for
 Broadcom STB AVS TMON
In-Reply-To: <20170809220257.4234-2-code@mmayer.net>
References: <20170809220257.4234-1-code@mmayer.net>
 <20170809220257.4234-2-code@mmayer.net>
Message-ID: <20170817151031.yh2wlpyvrp2qvhac@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 09, 2017 at 03:02:54PM -0700, Markus Mayer wrote:
> From: Brian Norris <computersforpeace@gmail.com>
> 
> Add binding for Broadcom STB thermal.
> 
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>  .../devicetree/bindings/thermal/brcm,avs-tmon.txt    | 20 ++++++++++++++++++++
>  MAINTAINERS                                          |  8 ++++++++
>  2 files changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt

Acked-by: Rob Herring <robh@kernel.org>
