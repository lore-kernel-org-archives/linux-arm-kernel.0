From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 24 Mar 2017 12:52:44 -0700
Subject: [PATCH 0/8] pinctrl: meson: add audio output pins
In-Reply-To: <20170323165101.29262-1-jbrunet@baylibre.com> (Jerome Brunet's
 message of "Thu, 23 Mar 2017 17:50:53 +0100")
References: <20170323165101.29262-1-jbrunet@baylibre.com>
Message-ID: <m2wpbeh2pf.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> This patchset adds the pinctrl definition and the related device-tree
> bindings of the i2s output and spdif output pins on the meson gxbb and
> gxl SoCs.
>
> This is part of the ongoing work to bring audio output suppot on the
> meson family. It was tested on the gxbb p200 and gxl p230.

Series looks good to me,

However, I'm not sure about Linus's preference, but most maintainers
(myself included) prefer a small description in the changelog, even if
it restates (with slightly more description) what's already in the
$SUBJECT.

Kevin
