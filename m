From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 31 Mar 2015 14:02:04 -0700
Subject: [RFC PATCH v3 2/2] clk: exynos5420: Make sure MDMA0 clock is
 enabled during suspend
In-Reply-To: <551976F1.1000605@collabora.co.uk> (Javier Martinez Canillas's
 message of "Mon, 30 Mar 2015 18:16:49 +0200")
References: <1427730803-28635-1-git-send-email-javier.martinez@collabora.co.uk>
 <1427730803-28635-3-git-send-email-javier.martinez@collabora.co.uk>
 <CA+Ln22FBpuzR06qCsVc7SXtLX2mhf901vDE5D-mT1+ijZ2G3sg@mail.gmail.com>
 <551976F1.1000605@collabora.co.uk>
Message-ID: <7hiodg98z7.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier Martinez Canillas <javier.martinez@collabora.co.uk> writes:

[...]

> Unfortunately I don't fully understand why this clock needs to be
> enabled. It would be good if someone at Samsung can explain in more
> detail what the real problem really is.

+1

Maybe Abhilash can shed some light here?

We really should know *why* this is needed because having the fix in the
clock driver just doesn't seem right.  It seems like the DMA driver
should be managing this clock.

Kevin
