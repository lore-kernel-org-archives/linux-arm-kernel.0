From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 09 Sep 2014 08:57:50 -0700
Subject: [PATCH/RFC 1/5] PM / Domains: Add DT bindings for power-on/off
 latencies
In-Reply-To: <1410183344-14756-2-git-send-email-geert+renesas@glider.be>
 (Geert Uytterhoeven's message of "Mon, 8 Sep 2014 15:35:40 +0200")
References: <1410183344-14756-1-git-send-email-geert+renesas@glider.be>
 <1410183344-14756-2-git-send-email-geert+renesas@glider.be>
Message-ID: <7h8ulskcqp.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Geert Uytterhoeven <geert+renesas@glider.be> writes:

> PM domain power on/off-latencies are properties of the hardware.
> In legacy code, they're specified from platform code.
> On DT platforms, their values should come from DT.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Nice.

Acked-by: Kevin Hilman <khilman@linaro.org>

Kevin
