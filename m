From: broonie@kernel.org (Mark Brown)
Date: Mon, 4 Sep 2017 17:42:35 +0100
Subject: [PATCH v6 09/12] ASoC: wm9712: add ac97 new bus support
In-Reply-To: <8760cyppvj.fsf@belgarion.home>
References: <20170902195414.3699-1-robert.jarzmik@free.fr>
 <20170902195414.3699-10-robert.jarzmik@free.fr>
 <20170904101849.7uefwhuqz4vtntrp@localhost.localdomain>
 <8760cyppvj.fsf@belgarion.home>
Message-ID: <20170904164235.dkw7ngqmycg7k3tl@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 04, 2017 at 03:14:40PM +0200, Robert Jarzmik wrote:
> Charles Keepax <ckeepax@opensource.cirrus.com> writes:

> > This bit is still missing the ifdef it has in the preceeding
> > patch.

> Damn, you're right, it's missing in both wm9705 and wm9712, but not in wm9713.
> That will be for the hopefully last volley of this serie.

Given that this just missed the merge window but has now been reviewed
by Takashi as well what I'm thinking is that it's going to be easiest to
apply the start of it now so hopefully no need to respin the whole
series so often.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170904/f87ef0ad/attachment-0001.sig>
