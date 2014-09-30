From: broonie@kernel.org (Mark Brown)
Date: Wed, 1 Oct 2014 00:09:06 +0100
Subject: [PATCH] ASoC: fsl: fix dependencies for wm8962
In-Reply-To: <20140930174241.GA1296@Asurada>
References: <1950588.ErdGoiHh8p@wuerfel> <20140930164510.GF4273@sirena.org.uk>
 <20140930174241.GA1296@Asurada>
Message-ID: <20140930230906.GQ4273@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 10:42:42AM -0700, Nicolin Chen wrote:
> On Tue, Sep 30, 2014 at 05:45:10PM +0100, Mark Brown wrote:

> > That select shouldn't be there in the first place, I asked Nicolin to
> > fix this when I applied the driver but he's not got round to it yet.

> I think I might have missed something around those days, even though
> the 'Applied' mail seemly doesn't have any comment against this part:
> http://mailman.alsa-project.org/pipermail/alsa-devel/2014-August/080083.html

> Is that possible for you to copy and paste the comments again?

I suspect it was on an earlier version of the patch or a cover letter;
IIRC you were resending while I was reviewing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141001/04bf7c83/attachment.sig>
