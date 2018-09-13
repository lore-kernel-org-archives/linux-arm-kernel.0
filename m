From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 12 Sep 2018 20:59:37 -0700
Subject: [PATCH] arm64: dts: meson: Switch simple-mfd and syscon order
In-Reply-To: <1532614438-7207-1-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Thu, 26 Jul 2018 16:13:58 +0200")
References: <1532614438-7207-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <7hh8iuxd1y.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The order between "syscon" and "simple-mfd" is important because in these
> particular cases, the node needs to be first a "simple-mfd" to expose
> it's sub-nodes, and later on a "syscon" to permit other nodes to access
> this register space through the "syscon" mechanism.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Applied to v4.20/dt64,

Kevin
