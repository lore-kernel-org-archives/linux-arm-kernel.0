From: broonie@kernel.org (Mark Brown)
Date: Wed, 31 Jul 2013 17:52:43 +0100
Subject: [PATCH 2/2] chipidea: Use devm_request_irq()
In-Reply-To: <20130731152932.GV2810@htj.dyndns.org>
References: <20130731111853.GJ9858@sirena.org.uk>
 <20130731113244.GI2810@htj.dyndns.org>
 <20130731115027.GN9858@sirena.org.uk>
 <20130731115527.GR2810@htj.dyndns.org>
 <20130731132708.GQ9858@sirena.org.uk>
 <20130731134215.GS2810@htj.dyndns.org>
 <20130731135751.GT9858@sirena.org.uk>
 <20130731140758.GT2810@htj.dyndns.org>
 <20130731152523.GW9858@sirena.org.uk>
 <20130731152932.GV2810@htj.dyndns.org>
Message-ID: <20130731165243.GX9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 11:29:32AM -0400, Tejun Heo wrote:

> Yeah, sure, thank you very much for your input.  It is of course
> strictly ordered and the documentation needs to be updated.

While I note the way you're saying this given the widespread adoption I
think there's a bit more effort needed on making sure people are aware
of this model and that it's possible to do it - most of the APIs with
devres support really ought to have things like a devm_clk_get_enable()
(an example discussed further up the thread) added to them.

devres has been quite widely adopted but not in a way that supports this
usage model.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130731/7ff5a400/attachment-0001.sig>
