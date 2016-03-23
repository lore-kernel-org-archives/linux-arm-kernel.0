From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 23 Mar 2016 12:12:43 -0700
Subject: [PATCH v3 0/2] Split pinctrl device for Meson8 / Meson8b and
 update docs
In-Reply-To: <1458724440-32228-1-git-send-email-carlo@caione.org> (Carlo
 Caione's message of "Wed, 23 Mar 2016 10:13:58 +0100")
References: <1458724440-32228-1-git-send-email-carlo@caione.org>
Message-ID: <7hio0dqa8k.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Carlo Caione <carlo@caione.org> writes:

> From: Carlo Caione <carlo@endlessm.com>
>
> With http://www.spinics.net/lists/devicetree/msg116771.html we split / refactor
> the pinctrl driver to have two different pinctrl devices for each bus.
>
> Unfortunately these two patches still haven't found their way to mainline.
> Reposting them as standalone patchset. Hopefully they can be ACKed as soon as
> possible.

Tested-by: Kevin Hilman <khilman@baylibre.com>

I confirm that this gets meson8b-odroidc1 booting again in mainline.

Kevin
