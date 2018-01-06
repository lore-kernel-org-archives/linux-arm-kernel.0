From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 05 Jan 2018 16:54:24 -0800
Subject: [PATCH] ARM64: dts: meson-gxl: add internal ethernet PHY irq
In-Reply-To: <20171218102713.4506-1-jbrunet@baylibre.com> (Jerome Brunet's
 message of "Mon, 18 Dec 2017 11:27:13 +0100")
References: <20171218102713.4506-1-jbrunet@baylibre.com>
Message-ID: <7h1sj324e7.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Add the interrupt of the internal ethernet PHY
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
> Hi Kevin,
>
> This changes depends on the net-next changes adding interrupt support [0].
> It is really important that this change is not merged before its
> dependency.
>
> If it is merged before, instead of polling, the phy would wait for an
> interrupt which has not been configured and will never fire.

Thanks for the warning. I'll wait and merge these after -rc1 to be sure
of all dependencies.

Kevin
