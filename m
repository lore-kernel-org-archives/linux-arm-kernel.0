From: broonie@kernel.org (Mark Brown)
Date: Sat, 19 Sep 2015 09:57:13 -0700
Subject: [PATCH v2 1/5] regulator: smd: Add floor and corner operations
In-Reply-To: <1442623929-4507-2-git-send-email-sboyd@codeaurora.org>
References: <1442623929-4507-1-git-send-email-sboyd@codeaurora.org>
 <1442623929-4507-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150919165712.GH30445@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2015 at 05:52:05PM -0700, Stephen Boyd wrote:

> +EXPORT_SYMBOL(qcom_rpm_set_floor);

The entire regulator API is EXPORT_SYMBOL_GPL(), adding plain
EXPORT_SYMBOL() exports is not good.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150919/ed392835/attachment.sig>
