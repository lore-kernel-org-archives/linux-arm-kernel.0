From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 19 Aug 2015 16:50:35 +0200
Subject: [PATCH v7 0/9] Fixes and new clocks support for Mediatek MT8173
In-Reply-To: <CAGS+omAj=BZXYXChJwC2Heq+2KVEV2EoRrhiQhtXZRHGaZ9tEw@mail.gmail.com>
References: <1439200228-318-1-git-send-email-jamesjj.liao@mediatek.com>
 <CAGS+omCya_0djzoVGhJchmaTtzo2z+JdnJHDjLipNMsZKV=MLQ@mail.gmail.com>
 <CAGS+omAj=BZXYXChJwC2Heq+2KVEV2EoRrhiQhtXZRHGaZ9tEw@mail.gmail.com>
Message-ID: <20150819145035.GN18700@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dan,

On Fri, Aug 14, 2015 at 12:01:06PM +0800, Daniel Kurtz wrote:
> On Tue, Aug 11, 2015 at 12:43 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> > Hi James,
> >
> > On Mon, Aug 10, 2015 at 5:50 PM, James Liao <jamesjj.liao@mediatek.com> wrote:
> >> This patchset is based on 4.2-rc2 and [1], and contains minor fixes and
> >> subsystem clocks support for Mediatek MT8173.
> >>
> >> The previous reviews can be found in [2].
> >>
> >> changes since v6:
> >> - Use DUMMY_RATE (0) instead of typical rate for clocks that we don't care
> >>   and not controlled in CCF.
> >
> > For the whole series:
> > Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
> 
> Hi Sascha,
> 
> Are you happy with these patches now?

Yes.

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
