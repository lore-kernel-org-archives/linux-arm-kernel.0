From: tony@atomide.com (Tony Lindgren)
Date: Mon, 24 Sep 2018 15:04:52 -0700
Subject: [PATCH 2/3] ARM: DTS: AM3517-EVM: Add support for UI board and
 Audio
In-Reply-To: <20180923153718.15095-2-aford173@gmail.com>
References: <20180923153718.15095-1-aford173@gmail.com>
 <20180923153718.15095-2-aford173@gmail.com>
Message-ID: <20180924220452.GH5662@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Adam Ford <aford173@gmail.com> [180923 15:41]:
> The full AM3517-EVM shipped with an add-on board which contained
> two Audio codecs, a GPIO expander with a variety of buttons, and
> some other features.  This patch enables these portions of the UI
> board because they don't directly conflict with existing features.

Applying this one into omap-for-v4.20/dt thanks.

Tony
