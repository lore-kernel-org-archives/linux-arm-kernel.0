From: broonie@kernel.org (Mark Brown)
Date: Mon, 14 Jul 2014 19:13:38 +0100
Subject: [PATCH RFC 2/2] regulator: twl: Re-add clk32kg to get wifi working
In-Reply-To: <53C3C77F.7080208@kpanic.de>
References: <1405338655-18415-1-git-send-email-sassmann@kpanic.de>
 <1405338655-18415-3-git-send-email-sassmann@kpanic.de>
 <20140714120051.GF6800@sirena.org.uk> <53C3C77F.7080208@kpanic.de>
Message-ID: <20140714181338.GR6800@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 14, 2014 at 02:05:19PM +0200, Stefan Assmann wrote:
> On 14.07.2014 14:00, Mark Brown wrote:

> >No, you need to implement clocks using the clock API.  Please read the
> >changelogs for the above commits...

> Yes, that's what I expected. Got any pointers for me how to do this?
> Never done that before, a little help would be appreciated.

There should be plenty of examples in drivers/clk?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140714/5fda622a/attachment.sig>
