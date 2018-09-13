From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 12 Sep 2018 21:18:50 -0700
Subject: [PATCH] arm64: dts: meson-axg: sort nodes consistently
In-Reply-To: <20180829154551.26729-1-jbrunet@baylibre.com> (Jerome Brunet's
 message of "Wed, 29 Aug 2018 17:45:51 +0200")
References: <20180829154551.26729-1-jbrunet@baylibre.com>
Message-ID: <7h4leuxc5x.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Sort DT nodes by address when possible, by node node name otherwise.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>
> Hi Kevin,
>
> This patch is same kind of clean-up we already did on gxbb and gxl some
> time ago. In the same fashion, it ends up being and ugly and almost unreadable
> patch, sorry about that :( I don't think there was a way to avoid it.
>
> The patch applies on top v4.19-rc1 + 3 DT audio patches which are in your
> v4.19/dt64 branch [0]
>
> There should be no functional change after applying this patch.
> I've tested it in on the s400 and so far, so good.

Thanks for the cleanup,

Applied to v4.20/dt64,

Kevin
