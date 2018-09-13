From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 13 Sep 2018 09:17:54 -0700
Subject: [PATCH RESEND] arm64: dts: meson: Switch simple-mfd and syscon
 order
In-Reply-To: <1536822747-13918-1-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Thu, 13 Sep 2018 09:12:27 +0200")
References: <1536822747-13918-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <7hzhwlv0b1.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The order between "syscon" and "simple-mfd" is important because in these
> particular cases, the node needs to be first a "simple-mfd" to expose
> it's sub-nodes, and later on a "syscon" to permit other nodes to access
> this register space through the "syscon" mechanism.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Applied to v4.20/dt64.

> ---
> Hi Kevin,
>
> I rebased the patch on top of your v4.20/dt64 branch.
>

Thanks for the quick respin.

Kevin
