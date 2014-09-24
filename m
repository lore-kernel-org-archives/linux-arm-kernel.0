From: mchehab@osg.samsung.com (Mauro Carvalho Chehab)
Date: Wed, 24 Sep 2014 20:25:14 -0300
Subject: [PATCH 15/18] [media] s5p_mfc_opr: Fix warnings
In-Reply-To: <CAOMZO5CoaX05r50p+Ug++napxZEoL_+CR8-T7tN6wtiSRfT1pw@mail.gmail.com>
References: <c8634fac0c56cfaa9bdad29d541e95b17c049c0a.1411597610.git.mchehab@osg.samsung.com>
 <ed21f64844bd63573466c2667fd035f9e650a5f9.1411597610.git.mchehab@osg.samsung.com>
 <CAOMZO5CoaX05r50p+Ug++napxZEoL_+CR8-T7tN6wtiSRfT1pw@mail.gmail.com>
Message-ID: <20140924202514.0b1c6a3c@recife.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Wed, 24 Sep 2014 20:02:19 -0300
Fabio Estevam <festevam@gmail.com> escreveu:

> Hi Mauro,
> 
> On Wed, Sep 24, 2014 at 7:27 PM, Mauro Carvalho Chehab
> <mchehab@osg.samsung.com> wrote:
> 
> 
> > drivers/media//platform/s5p-mfc/s5p_mfc_opr.c:44:2: warning: format ?%d? expects argument of type ?int?, but argument 4 has type ?size_t? [-Wformat=]
> 
> ...
> 
> > -       mfc_debug(3, "Allocating priv: %d\n", b->size);
> > +       mfc_debug(3, "Allocating priv: %zd\n", b->size);
> 
> This should be %zu instead.

Thanks! fixed on both patches.

Regards,
Mauro
