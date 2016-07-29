From: robh@kernel.org (Rob Herring)
Date: Fri, 29 Jul 2016 16:11:09 -0500
Subject: [PATCH v3 3/6] binding-doc: usb: usb-device: add optional
 properties for power sequence
In-Reply-To: <1469007629-31757-4-git-send-email-peter.chen@nxp.com>
References: <1469007629-31757-1-git-send-email-peter.chen@nxp.com>
 <1469007629-31757-4-git-send-email-peter.chen@nxp.com>
Message-ID: <20160729211109.GA2788@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2016 at 05:40:26PM +0800, Peter Chen wrote:
> Add optional properties for power sequence.
> 
> Signed-off-by: Peter Chen <peter.chen@nxp.com>
> ---
>  Documentation/devicetree/bindings/usb/usb-device.txt | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

This probably should be put into a binding doc for the specific hub 
chip, but this is fine for now.

Acked-by: Rob Herring <robh@kernel.org>
