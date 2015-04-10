From: mturquette@linaro.org (Michael Turquette)
Date: Fri, 10 Apr 2015 16:40:39 -0700
Subject: [PATCH 0/3] clk: meson: Add clock controller
In-Reply-To: <CAOQ7t2YmJPZuJJ0pTapX2p9J+MrTUuTjoOvxfiwqqvsRZ0GnYg@mail.gmail.com>
References: <1425313322-18567-1-git-send-email-carlo@caione.org>
 <CAOQ7t2YmJPZuJJ0pTapX2p9J+MrTUuTjoOvxfiwqqvsRZ0GnYg@mail.gmail.com>
Message-ID: <20150410234039.18916.19318@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Carlo Caione (2015-03-15 14:03:07)
> On Mon, Mar 2, 2015 at 5:21 PM, Carlo Caione <carlo@caione.org> wrote:
> > From: Carlo Caione <carlo@endlessm.com>
> >
> > This patchset introduces preliminary support for the clock controller
> > found on Amlogic MesonX SoCs and enables it for the Meson8b.
> >
> > DTS patches with support for Meson8b SoCs will follow.
> >
> > Carlo Caione (3):
> >   clk: meson: Add support for Meson clock controller
> >   clk: meson: Document bindings for Meson8b clock controller
> >   clk: meson8b: Add support for Meson8b clocks
> 
> Hi Mike,
> any feedback on this patchset?

Hi Carlo,

This series looks good. The ascii art describing the hardware is
especially appreciated. I had one small question regarding your use of
the clock rate change notifier for the meson 8b cpu clocks. Once we've
worked that out then I can merge these into clk-next.

Regards,
Mike

> 
> -- 
> Carlo Caione
