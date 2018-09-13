From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 12 Sep 2018 20:59:54 -0700
Subject: [PATCH] ARM64: dts: meson-gx: increase default shared CMA pool
 size
In-Reply-To: <1536085844-29328-1-git-send-email-christianshewitt@gmail.com>
 (Christian Hewitt's message of "Tue, 4 Sep 2018 22:30:43 +0400")
References: <1536085844-29328-1-git-send-email-christianshewitt@gmail.com>
Message-ID: <7hd0tixd1h.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Christian Hewitt <christianshewitt@gmail.com> writes:

> Devices using the new V4L2 mem2mem vdec require a larger CMA pool. As
> nearly all GX* devices are video/media focused and will use it, set a
> larger (256MB) default value.
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>

Applied to v4.20/dt64,

Kevin
