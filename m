From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 11 Mar 2012 11:41:04 +0000
Subject: [PATCH 3/4] mx31moboard: Add ssi configuration
In-Reply-To: <1331304916-4724-4-git-send-email-philippe.retornaz@epfl.ch>
References: <1331304916-4724-1-git-send-email-philippe.retornaz@epfl.ch>
 <1331304916-4724-2-git-send-email-philippe.retornaz@epfl.ch>
 <1331304916-4724-3-git-send-email-philippe.retornaz@epfl.ch>
 <1331304916-4724-4-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <20120311114104.GC3233@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 09, 2012 at 03:55:15PM +0100, Philippe R?tornaz wrote:

> +	mxc_audmux_v2_configure_port(MX31_AUDMUX_PORT1_SSI0,
> +		MXC_AUDMUX_V2_PTCR_SYN |
> +		MXC_AUDMUX_V2_PTCR_TFSDIR |

This will need to be rebased off current code, the audmux has been moved
into sound/soc.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120311/ba39bc23/attachment-0001.sig>
