From: broonie@kernel.org (Mark Brown)
Date: Mon, 1 Jul 2013 20:06:26 +0100
Subject: [PATCH v5 1/4] clk: hi3xxx: add clock support
In-Reply-To: <20130617215039.GM28497@quad.lixom.net>
References: <1371459376-25438-1-git-send-email-haojian.zhuang@linaro.org>
 <1371459376-25438-2-git-send-email-haojian.zhuang@linaro.org>
 <20130617215039.GM28497@quad.lixom.net>
Message-ID: <20130701190626.GM27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 02:50:39PM -0700, Olof Johansson wrote:

> > +   hisilicon,clkdiv-table property.
> > + - hisilicon,clkdiv-table : list of value that are used to configure clock

> For a binding that is your own, you don't need to prefix the properties.
> Prefixes are mostly used when adding new vendor-specific attributes to a common
> binding.

People seem to be *very* keen on adding them for all bindings for some
reason.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130701/d8c039f1/attachment.sig>
