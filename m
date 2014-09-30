From: nicoleotsuka@gmail.com (Nicolin Chen)
Date: Tue, 30 Sep 2014 16:26:18 -0700
Subject: [PATCH] ASoC: fsl: fix dependencies for wm8962
In-Reply-To: <20140930230906.GQ4273@sirena.org.uk>
References: <1950588.ErdGoiHh8p@wuerfel> <20140930164510.GF4273@sirena.org.uk>
 <20140930174241.GA1296@Asurada>
 <20140930230906.GQ4273@sirena.org.uk>
Message-ID: <20140930232617.GA1732@Asurada>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 01, 2014 at 12:09:06AM +0100, Mark Brown wrote:
> On Tue, Sep 30, 2014 at 10:42:42AM -0700, Nicolin Chen wrote:
> > On Tue, Sep 30, 2014 at 05:45:10PM +0100, Mark Brown wrote:
> 
> > > That select shouldn't be there in the first place, I asked Nicolin to
> > > fix this when I applied the driver but he's not got round to it yet.
> 
> > I think I might have missed something around those days, even though
> > the 'Applied' mail seemly doesn't have any comment against this part:
> > http://mailman.alsa-project.org/pipermail/alsa-devel/2014-August/080083.html
> 
> > Is that possible for you to copy and paste the comments again?
> 
> I suspect it was on an earlier version of the patch or a cover letter;
> IIRC you were resending while I was reviewing.

I checked the Archive, the patch only got one version without cover
letter. And this version only got one reply which is the Applied mail.
I guess your earlier reply might have been swallowed somehow so I
couldn't read it.

Anyway, it's my fault that I didn't pay attention to the Kconfig part.
The driver is initially designed for imx-cs42888, but I changed my mind
to merge it with others before I sent it. And I didn't rewrite the part
inside the Kconfig. Will be careful next time.

And I think Fabio's suggestion/patch has no problem right?

Thank you
Nicolin
