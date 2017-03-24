From: jbrunet@baylibre.com (Jerome Brunet)
Date: Fri, 24 Mar 2017 22:23:30 +0100
Subject: [PATCH 0/8] pinctrl: meson: add audio output pins
In-Reply-To: <m2wpbeh2pf.fsf@baylibre.com>
References: <20170323165101.29262-1-jbrunet@baylibre.com>
 <m2wpbeh2pf.fsf@baylibre.com>
Message-ID: <1490390610.29739.18.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-03-24 at 12:52 -0700, Kevin Hilman wrote:
> Jerome Brunet <jbrunet@baylibre.com> writes:
> 
> > This patchset adds the pinctrl definition and the related device-tree
> > bindings of the i2s output and spdif output pins on the meson gxbb and
> > gxl SoCs.
> > 
> > This is part of the ongoing work to bring audio output suppot on the
> > meson family. It was tested on the gxbb p200 and gxl p230.
> 
> Series looks good to me,
> 
> However, I'm not sure about Linus's preference, but most maintainers
> (myself included) prefer a small description in the changelog, even if
> it restates (with slightly more description) what's already in the
> $SUBJECT.

Understood. thanks for pointing it out.
This series was going to clash with Neil's pinctrl fixes anyway.

I'll respin it taking this into account.

> 
> Kevin
