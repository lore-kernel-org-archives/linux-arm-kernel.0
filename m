From: broonie@kernel.org (Mark Brown)
Date: Tue, 31 Mar 2015 08:00:01 +0100
Subject: [PATCH 1/2] ASoC: cygnus-audio: adding device tree bindings
In-Reply-To: <1427771784-29950-2-git-send-email-sbranden@broadcom.com>
References: <1427771784-29950-1-git-send-email-sbranden@broadcom.com>
 <1427771784-29950-2-git-send-email-sbranden@broadcom.com>
Message-ID: <20150331070001.GF2869@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 30, 2015 at 08:16:23PM -0700, Scott Branden wrote:

> +Required properties:
> +	- compatible : "brcm,cygnus-audio"
> +	- #address-cells: 32bit valued, 1 cell. <1>
> +	- #size-cells:  32bit valued, 1 cell. <1>
> +	- reg : Should contain audio registers location and length
> +	- interrupts: audio DMA interrupt number
> +
> +SSP Subnode properties:

This document does rather gloss over the fact that the binding requires
subnodes, it should mention this requirement and say what they mean.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150331/52e49f8d/attachment.sig>
