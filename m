From: mturquette@baylibre.com (Michael Turquette)
Date: Tue, 11 Oct 2016 08:00:00 -0000
Subject: [PATCH v2 3/3] ARM64: dts: meson-gxbb: Add GXBB AO Clock and
 Reset node
In-Reply-To: <m260qjjx26.fsf@baylibre.com>
References: <1471514928-3341-1-git-send-email-narmstrong@baylibre.com>
 <1471514928-3341-4-git-send-email-narmstrong@baylibre.com>
 <7hk2fc76xx.fsf@baylibre.com>
 <147208015014.66208.14165603610884470316@resonance>
 <m260qjjx26.fsf@baylibre.com>
Message-ID: <147285935146.69079.16726192933831918899@resonance>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Kevin Hilman (2016-08-29 10:37:37)
> Michael Turquette <mturquette@baylibre.com> writes:
> 
> > Quoting Kevin Hilman (2016-08-19 15:03:06)
> >> Neil Armstrong <narmstrong@baylibre.com> writes:
> >> 
> >> > Add the AO clock controller node for the AmLogic GXBB SoC.
> >> >
> >> > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >> > ---
> >> 
> >> Applying this to the amlogic tree, but will need to wait a cycle due to
> >> include dependencies on the bindings, which are going through the clock
> >> tree.
> >
> > FYI, for picked patches, Stephen and I create a stable branch for each
> > platform. You can pull this into your tree if you want, just let us know
> > so we'll be sure not to rebase:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-meson-gxbb-ao
> >
> 
> OK, I'll be using clk-meson-gxb and clk-meson-gxbb-ao.

Heads up, I merged clk-meson-gxbb-ao into clk-meson-gxbb yesterday to
make it easier to merge the emmc clock gate patches. If you haven't
pulled clk-meson-gxbb-ao already then you can just re-pull
clk-meson-gxbb and you'll get it.

Regards,
Mike

> 
> Thanks,
> 
> Kevin
