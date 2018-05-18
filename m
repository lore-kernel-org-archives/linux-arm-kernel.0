From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 18 May 2018 16:29:55 +0200
Subject: [PATCH v2 1/6] spi: sun6i: coding style/readability improvements
In-Reply-To: <20180517070307.GP20254@sirena.org.uk>
References: <20180330125047.13936-1-ssuloev@orpaltech.com>
 <20180330125047.13936-2-ssuloev@orpaltech.com>
 <20180517070307.GP20254@sirena.org.uk>
Message-ID: <20180518142955.lmeb5bkeo4wyv2ue@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, May 17, 2018 at 04:03:07PM +0900, Mark Brown wrote:
> On Fri, Mar 30, 2018 at 03:50:42PM +0300, Sergey Suloev wrote:
> > Minor changes to fulfill the coding style and improve
> > the readability of the code.
> > 
> > Changes in v2:
> > 1) Fixed issue with misplacing a piece of code that requires access
> > to the transfer structure into sun6i_spi_prepare_message() function
> > where the transfer structure is not available.
> 
> Place inter-version changelogs after the --- as covered in
> SubmittingPatches.
> 
> > 
> > Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>
> > 
> > ---
> >  drivers/spi/spi-sun6i.c | 97 +++++++++++++++++++++++++++++--------------------
> 
> This is a *very* large change doing a whole bunch of different things,
> including some fairly substantial changes like moving things into
> different functions but the changelog doesn't provide any details at all
> on what the changes are supposed to be.  This makes it difficult to
> review, it should be split into separate patches each doing one clerly
> described thing (I'm guessing this might be part of why the AllWinner
> maintainers haven't reviewed the series).

We didn't really review them because most of the changes done here
were also applicable to the sun4i series that was sent pretty much at
the same time:
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-April/570056.html

We should have made that clearer, sorry.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180518/00ba89c6/attachment.sig>
