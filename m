From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 25 Aug 2014 13:26:38 -0600
Subject: [PATCH v2 5/9] of: Add NVIDIA Tegra xHCI controller binding
In-Reply-To: <1408381705-3623-6-git-send-email-abrestic@chromium.org>
References: <1408381705-3623-1-git-send-email-abrestic@chromium.org>
 <1408381705-3623-6-git-send-email-abrestic@chromium.org>
Message-ID: <53FB8DEE.6050300@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/18/2014 11:08 AM, Andrew Bresticker wrote:
> Add device-tree binding documentation for the xHCI controller present
> on Tegra124 and later SoCs.

> diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra124-xhci.txt b/Documentation/devicetree/bindings/usb/nvidia,tegra124-xhci.txt

> +Required properties:
> +--------------------

> + - mboxes: Must contain an entry for the XUSB host mailbox channel.
> +   See ../mailbox/mailbox.txt for details.

I'd like to use mbox-names here too.
