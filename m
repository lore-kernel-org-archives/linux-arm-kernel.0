From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 Nov 2015 14:07:46 +0000
Subject: [PATCH v2 1/2] dt-bindings: sound: Add DT bindings for Broadcom
 Cygnus audio
In-Reply-To: <1446502284-23907-2-git-send-email-ssimran@broadcom.com>
References: <1446502284-23907-2-git-send-email-ssimran@broadcom.com>
Message-ID: <20151104140746.GE1717@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 02, 2015 at 02:11:23PM -0800, Simran Rai wrote:

> +- channel-group: Surround sound grouping that controls which channel
> +  outputs belong to a group, specifically useful in Multi-channel
> +  Interfaces grouping of serial port. In multi-channel stereo, use
> +  "2_0", in 3.1 multi-channel grouping, use "3_1" and in 5.1
> +  multi-channel grouping, use "5_1".

I don't really understand what this means or why this is not runtime
configured.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151104/a7a27bb4/attachment-0001.sig>
