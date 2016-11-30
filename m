From: robh@kernel.org (Rob Herring)
Date: Wed, 30 Nov 2016 15:53:31 -0600
Subject: [PATCH 1/2] dt-bindings: usb: add DT binding for s3c2410 USB
 OHCI controller
In-Reply-To: <1480085249-25014-2-git-send-email-sergio.prado@e-labworks.com>
References: <1480085249-25014-1-git-send-email-sergio.prado@e-labworks.com>
 <1480085249-25014-2-git-send-email-sergio.prado@e-labworks.com>
Message-ID: <20161130215331.v3mcm4zyojlagynz@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 25, 2016 at 12:47:28PM -0200, Sergio Prado wrote:
> Adds the device tree bindings description for Samsung S3C2410 and
> compatible USB OHCI controller.
> 
> Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
> ---
>  .../devicetree/bindings/usb/s3c2410-usb.txt        | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/s3c2410-usb.txt

Acked-by: Rob Herring <robh@kernel.org>
