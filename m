From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 07 Oct 2016 07:43:48 -0700
Subject: [PATCH] ARM64: dts: meson-gx: Add missing L2 cache node
In-Reply-To: <1475675630-31514-1-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Wed, 5 Oct 2016 15:53:50 +0200")
References: <1475675630-31514-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <7h7f9kfcd7.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> In order to remove the boot warning :
> [    2.290933] Unable to detect cache hierarchy from DT for CPU 0
> And add missing L2 cache hierarchy information, add a simple l2 cache node
> and reference it from the A53 cpu nodes.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Applied to v4.10/dt64.

Kevin
