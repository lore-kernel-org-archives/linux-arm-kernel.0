From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 10 Nov 2014 20:32:08 +0100
Subject: [PATCH v9 07/12] coresight-etm: add CoreSight ETM/PTM driver
In-Reply-To: <CANLsYkxivqgyRZspS2uP9Mkwit4obCjZxYr0YUhR3G_zQejERg@mail.gmail.com>
References: <1415038066-22423-1-git-send-email-mathieu.poirier@linaro.org>
 <1415038066-22423-8-git-send-email-mathieu.poirier@linaro.org>
 <1415615671.4862.30.camel@x220>
 <CANLsYkxivqgyRZspS2uP9Mkwit4obCjZxYr0YUhR3G_zQejERg@mail.gmail.com>
Message-ID: <1415647928.21229.23.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-11-10 at 08:40 -0700, Mathieu Poirier wrote:
> On 10 November 2014 03:34, Paul Bolle <pebolle@tiscali.nl> wrote:
> > On Mon, 2014-11-03 at 11:07 -0700, mathieu.poirier at linaro.org wrote:
> >> +#ifdef CONFIG_CORESIGHT_SOURCE_ETM_DEFAULT_ENABLE
> >
> > There's no Kconfig symbol CORESIGHT_SOURCE_ETM_DEFAULT_ENABLE. Neither
> > is there a preprocessor definition of this macro. So why was this
> > added?
> 
> Correct - the feature (as we really want it) is currently being worked
> on but not yet part of the code base.  The default option probably
> should have been removed but it doesn't do much else when mandating
> one to add a boot option on the kernel cmd line.

I'm afraid I'm not sure what you mean here. Anyhow, using a Kconfig
symbol to set a default for something that can also be set through a
kernel parameter might be considered overdoing it. But that's not for me
to decide.

Unless the patch that adds this Kconfig symbol takes a long time to land
in linux-next, I won't be bothering you again.

Thanks,


Paul Bolle
