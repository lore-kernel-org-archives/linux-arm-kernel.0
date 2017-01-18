From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Wed, 18 Jan 2017 20:40:34 +0100
Subject: [PATCH 0/5] meson-gx: reset RGMII PHYs and configure TX delay
In-Reply-To: <m2a8ao1833.fsf@baylibre.com>
References: <20161202234739.22929-1-martin.blumenstingl@googlemail.com>
 <m2a8ao1833.fsf@baylibre.com>
Message-ID: <CAFBinCACbeZPRXQO4OA5mJdGRvMkQoUmQEAKCi8KU2ZvrspF6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin,

On Wed, Jan 18, 2017 at 8:28 PM, Kevin Hilman <khilman@baylibre.com> wrote:
> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
>
>> This partially fixes the 1000Mbit/s ethernet TX throughput issues (on
>> networks which are not affected by the EEE problem, as reported here:
>
> Based on the discussions with Jerome, I'm dropping this series from the
> v4.11/dt64 branch for now.
what is you opinion on having the MDIO node in meson-gx (and keeping
GXBB and GXL/GXM consistent) vs not having PHY autodetection for GXBB
(= not having the MDIO in meson-gx)?
I cannot send a v2 until we have a decision for this

> This series also had a small conflict with Jerome's fix[1] for the
> odroid-c2, so please rebase any updates here on my v4.10/fixes branch.
will keep that in mind, noted.
