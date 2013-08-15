From: broonie@kernel.org (Mark Brown)
Date: Thu, 15 Aug 2013 14:39:25 +0100
Subject: [PATCH 2/5] ASoC: pxa: pxa-ssp: add DT bindings
In-Reply-To: <520CB2B3.9050804@gmail.com>
References: <1376296961-20564-1-git-send-email-zonque@gmail.com>
 <1376296961-20564-3-git-send-email-zonque@gmail.com>
 <20130815103358.GY2401@sirena.org.uk> <520CB2B3.9050804@gmail.com>
Message-ID: <20130815133925.GA30073@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 15, 2013 at 12:51:31PM +0200, Daniel Mack wrote:

> Hmm, and you don't like the approach either of having upstream ports and
> assign users to it via phandles?

I don't know what that means, sorry.

> Also note that the last patch in that series ("ASoC: pxa: add DT
> bindings for pxa2xx-pcm") can be omitted, as Lars pointed out. I'll have
> to care for a proper solution at some point.

I applied it since we were already adding a dummy device for the DAI.  I
can revert it if this work without that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130815/909e9632/attachment.sig>
