From: broonie@kernel.org (Mark Brown)
Date: Fri, 18 Oct 2013 18:31:26 +0100
Subject: [PATCHv1 8/8] Documentation: Add device tree bindings for
 Freescale VF610 sound.
In-Reply-To: <1382000477-17304-9-git-send-email-Li.Xiubo@freescale.com>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-9-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <20131018173126.GU2443@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 17, 2013 at 05:01:17PM +0800, Xiubo Li wrote:

> +  -- Power supplies:
> +     * Mic Bias
> +
> +  -- SGTL5000 pins:
> +     * MIC_IN
> +     * LINE_IN
> +     * HP_OUT
> +     * LINE_OUT

Things that are part of the CODEC should be part of the CODEC binding
and this binding should reference that - this way the information
doesn't have to be replicated by all boards using the CODEC and if new
devices are supported by the CODEC driver then only that needs updating
hopefully.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131018/5c57a830/attachment.sig>
