From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 6 Jul 2018 08:54:58 +0200
Subject: [PATCH v2 18/23] dt-bindings: thermal: armada: add reference to
 new bindings
In-Reply-To: <CAL_JsqL9h4RExZtm5cER-5kNvMpDzH-4MwcmY7VOLXB9-uEYYA@mail.gmail.com>
References: <20180625151239.20976-1-miquel.raynal@bootlin.com>
 <20180625151239.20976-19-miquel.raynal@bootlin.com>
 <20180703213011.GA13190@rob-hp-laptop>
 <20180705120528.4b923e16@xps13>
 <CAL_JsqL9h4RExZtm5cER-5kNvMpDzH-4MwcmY7VOLXB9-uEYYA@mail.gmail.com>
Message-ID: <20180706085458.6ed1a483@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Rob Herring <robh@kernel.org> wrote on Thu, 5 Jul 2018 12:03:04 -0600:

> On Thu, Jul 5, 2018 at 4:05 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >
> > Hi Rob,
> >
> > Rob Herring <robh@kernel.org> wrote on Tue, 3 Jul 2018 15:30:11 -0600:
> >  
> > > On Mon, Jun 25, 2018 at 05:12:34PM +0200, Miquel Raynal wrote:  
> > > > New bindings (with the syscon and the overheat interrupt) are available  
> > >
> > > What interrupt? It's not in your new binding.  
> 
> ???

I forgot that point, my bad.

Initially this series introduced an overheat interrupt. Due to some
dependencies I split the original series in two: this one and another
one just to add support for the interrupt.

This is a stale comment I forgot to remove (again in the v3), sorry.

I'll wait for Eduardo's feedback and repost eventually without the
parenthesis.

Thanks,
Miqu?l
