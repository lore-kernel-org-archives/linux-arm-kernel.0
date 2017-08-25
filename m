From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 24 Aug 2017 17:08:09 -0700
Subject: [PATCH v2 0/2] ARM64: dts: meson-gx: Enable CEC
In-Reply-To: <1501852333-3560-1-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Fri, 4 Aug 2017 15:12:11 +0200")
References: <1501852333-3560-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <7hwp5sfr12.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> This patchset enables :
>  - Update the AO domain clkc to new bindings
>  - AO CEC Controller linked with the HDMI controller all HDMI supported boards
>
> This patchset depends on the clock bindings posted in [1].

Applied to v4.14/dt64, and just sent with round2 of the dt64 pull
request.

Kevin
