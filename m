From: broonie@kernel.org (Mark Brown)
Date: Thu, 15 Aug 2013 11:33:58 +0100
Subject: [PATCH 2/5] ASoC: pxa: pxa-ssp: add DT bindings
In-Reply-To: <1376296961-20564-3-git-send-email-zonque@gmail.com>
References: <1376296961-20564-1-git-send-email-zonque@gmail.com>
 <1376296961-20564-3-git-send-email-zonque@gmail.com>
Message-ID: <20130815103358.GY2401@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 12, 2013 at 10:42:38AM +0200, Daniel Mack wrote:
> The pxa ssp DAI acts as a user of a pxa ssp port, and needs an
> appropriate 'port' phandle in DT to reference the upstream.

I've applied this and the rest of the series though I'm not really that
happy about having a binding for the DAI in the DT since there's at best
tenouous hardware there.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130815/f096104b/attachment.sig>
