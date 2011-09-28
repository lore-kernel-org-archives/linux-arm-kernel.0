From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 28 Sep 2011 13:29:18 +0100
Subject: [PATCHv2 08/10] ARM: u300: convert to MULTI_IRQ_HANDLER
In-Reply-To: <CACRpkdarydeYAyOV8Cm134TtPeh9_qFSqWPkvpZjUE9yPNNtJA@mail.gmail.com>
References: <1317206507-18867-1-git-send-email-jamie@jamieiles.com>
	<1317206507-18867-9-git-send-email-jamie@jamieiles.com>
	<CACRpkdYOdWA2vg2zq+nhOPSvPN7zdy9NVsOcqfZ7i9W5Sq5cpw@mail.gmail.com>
	<20110928120340.GH17204@pulham.picochip.com>
	<CACRpkdarydeYAyOV8Cm134TtPeh9_qFSqWPkvpZjUE9yPNNtJA@mail.gmail.com>
Message-ID: <20110928122918.GJ17204@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2011 at 02:18:14PM +0200, Linus Walleij wrote:
> On Wed, Sep 28, 2011 at 2:03 PM, Jamie Iles <jamie@jamieiles.com> wrote:
> 
> >> vic_single_handle_irq() needs to be modified to handle several
> >> ranges or atleast two.
> >
> > The platform IRQ handler is actually vic_handle_irq() that internally
> > calls vic_single_handle_irq() for each registered vic (in the order of
> > registration).
> 
> Ah I get it I'm dead wrong as usual :-)
> 
> I tried to apply them to test but Iget into dependency trouble with
> the referenced required patches, do you have some handy
> git branch with all stuff applied in order that I can pull in and
> test off?

Sure,

	git://github.com/jamieiles/linux-2.6-ji.git vic-dt

has all of the dependencies in there too.  Thanks for taking a look at 
the patches Linus!

Jamie
