From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 19 Mar 2018 16:44:50 -0700
Subject: [PATCH] ARM64: dts: meson-gx: make efuse read-only
In-Reply-To: <20180316145021.8517-1-jbrunet@baylibre.com> (Jerome Brunet's
 message of "Fri, 16 Mar 2018 15:50:21 +0100")
References: <20180316145021.8517-1-jbrunet@baylibre.com>
Message-ID: <7h370vsk99.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> efuse is one time programmable, so it is safer to deny write request
> to this memory, unless the user is savvy enough to remove the read-only
> flag from DTB
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Applied to v4.17/dt64,

Thanks,

Kevin
