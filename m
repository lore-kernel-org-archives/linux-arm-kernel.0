From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 28 Apr 2015 19:42:32 -0600
Subject: [PATCH 1/3] dt/bindings: Add binding for the Raspberry Pi firmware
 driver
In-Reply-To: <1430176449-12322-2-git-send-email-eric@anholt.net>
References: <1430176449-12322-1-git-send-email-eric@anholt.net>
 <1430176449-12322-2-git-send-email-eric@anholt.net>
Message-ID: <55403708.7080406@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/2015 05:14 PM, Eric Anholt wrote:

This one really needs a patch description, to indicate what kind of
thing this patch introduces a binding for.

> diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,firmware.txt b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,firmware.txt

> +Required properties:
> +
> +- compatible:	Should be "rasbperrypi,firmware"
> +- mboxes:	Single-entry list which specifies which mailbox controller
> +		  and channel is used.

It'd be nice to mention that ../../mailbox/mailbox.txt defines the
semantics of this property.
