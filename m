From: samuel.ortiz@intel.com (Samuel Ortiz)
Date: Thu, 4 Oct 2012 15:51:30 +0200
Subject: [PATCH 0/7] Add support for Freescale's mc34708 to mc13xxx driver
In-Reply-To: <CAOMZO5BqZpy5Cz0BxbpdOY=sjMjhSOjfQZmJ4j7Xwe6Q7x6Yig@mail.gmail.com>
References: <1342087073-3892-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <11987916.rOoNGcb1ly@dev1>
 <CAOMZO5AVP1L-6A7cmV-kQEfG1C+vczFKT=sQbFtLJDaGau0kRg@mail.gmail.com>
 <CAOMZO5BqZpy5Cz0BxbpdOY=sjMjhSOjfQZmJ4j7Xwe6Q7x6Yig@mail.gmail.com>
Message-ID: <20121004135130.GC5554@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Thu, Oct 04, 2012 at 10:01:21AM -0300, Fabio Estevam wrote:
> Hi Samuel,
> 
> On Wed, Sep 5, 2012 at 11:22 AM, Fabio Estevam <festevam@gmail.com> wrote:
> > Hi Samuel,
> >
> > On Thu, Jul 12, 2012 at 8:02 PM, Marc Reilly <marc@cpdesign.com.au> wrote:
> >> Hi Uwe,
> >>
> >>> This series was tested on a Phytec pcm038 (mc13783 on spi) using
> >>> traditional boot (i.e. not dt) and on a i.MX53 based machine (mc34708 on
> >>> i2c) using dt boot.
> >>>
> >>> Philippe's patches are already in next, they are just included here for
> >>> those who want to test the patches. The 'mfd/mc13xxx: drop modifying
> >>> driver's id_table in probe' was already sent out yesterday and is
> >>> included here because the last patch depends on it.
> >>>
> >>
> >> For all patches (that don't already have it):
> >> Acked-by: Marc Reilly <marc@cpdesign.com.au>
> >
> > Can this series be applied?
> 
> Any comments on this series, please?
Did you send it to my samuel.ortiz at intel.com email ? I never look at it when
going through my MFD backlog, which is why it was not applied. Which is why it
won't be part of the 3.7 merge window, sorry about that.

 
> I want to add mc34708 support to mx53qsb and need this series to be applied.
I understand. I'll queue it to my for-next branch as soon as the merge window
is closed.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
