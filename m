From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Feb 2014 17:12:46 +0000
Subject: [PATCH 3/3] mfd: axp20x: Add bindings documentation
In-Reply-To: <1391875428-6281-4-git-send-email-carlo@caione.org>
References: <1391875428-6281-1-git-send-email-carlo@caione.org>
 <1391875428-6281-4-git-send-email-carlo@caione.org>
Message-ID: <20140212171246.GG28112@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 08, 2014 at 05:03:48PM +0100, Carlo Caione wrote:
> Bindings documentation for the axp20x driver. In this file also two
> sub-nodes (PEK and regulators) are documented.

You probably want to CC bindings to the maintianers for the relevant
subsystes too.

> +	- dcdc-freq : defines the work frequency of DC-DC where
> +		      F=(1+dcdc-freq*5%)*1.5MHz

It sees a bit nicer to either have this be the frequency and work back
to the register setting or name it after the register field that gets
updated as a result.  I'm also not sure what *5% means - I'm guessing
it's *0.05 but it'd be clearer to just write that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140212/a4448312/attachment.sig>
