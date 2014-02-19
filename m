From: broonie@kernel.org (Mark Brown)
Date: Wed, 19 Feb 2014 13:47:26 +0900
Subject: [PATCH v2 1/5] mfd: add bcm590xx pmu DT binding
In-Reply-To: <1392765432-9111-2-git-send-email-mporter@linaro.org>
References: <1392765432-9111-1-git-send-email-mporter@linaro.org>
 <1392765432-9111-2-git-send-email-mporter@linaro.org>
Message-ID: <20140219044726.GC2669@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 06:17:08PM -0500, Matt Porter wrote:

> +
> +				rfldo_reg: regulator at 0 {
> +					reg = <0>;

What do these reg values mean, they don't seem to be documented in the
binding?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140219/5424dd98/attachment-0001.sig>
