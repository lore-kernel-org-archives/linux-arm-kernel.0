From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 11 Dec 2013 09:59:43 +0000
Subject: [GIT PULL] two Integrator devicetree patches
In-Reply-To: <878uvs75it.fsf@linaro.org>
References: <CACRpkdZcrEtHC+Q0YHOuL8yXQrMixL=n2Nagbk6NBAmdmnnXHw@mail.gmail.com>
 <878uvs75it.fsf@linaro.org>
Message-ID: <20131211095943.GB17681@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 09:36:10PM +0000, Kevin Hilman wrote:
> +Mark Rutland
> 
> Linus Walleij <linus.walleij@linaro.org> writes:
> 
> > Hi ARM SoC folks,
> >
> > here are two patches targeted for v3.14 that I'd like includes
> > in ARM SoC for testing in -next.
> >
> > Please pull them in!
> >
> > Yours,
> > Linus Walleij
> >
> >
> > The following changes since commit dc1ccc48159d63eca5089e507c82c7d22ef60839:
> >
> >   Linux 3.13-rc2 (2013-11-29 12:57:14 -0800)
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
> > tags/integrator-v3.14-1
> >
> > for you to fetch changes up to 307b96677c98bc444262e3d1a7d26c0ca8a1c6e0:
> >
> >   ARM: integrator: move EBI to the device tree (2013-12-04 16:22:31 +0100)
> >
> > ----------------------------------------------------------------
> > Two integrator device tree patches for v3.14:
> >
> > - Delete some static core module mappings.
> >
> > - Move EBI location to the device tree.
> >
> > ----------------------------------------------------------------
> > Linus Walleij (2):
> >       ARM: integrator: delete static core module mappings
> >       ARM: integrator: move EBI to the device tree
> >
> >  Documentation/devicetree/bindings/arm/arm-boards |  8 ++++
> 
> This change looks pretty straight forward to me, but it would be extra
> special nice to see an Ack from a DT maintainer on this change.  Seems
> you and Mark Rutland had some discussions on an earlier version of this
> change, so maybe he's the right one to bless this one?

I have no issues with this. Feel free to add my ACK.

Thanks,
Mark.
