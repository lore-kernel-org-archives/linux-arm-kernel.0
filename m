From: joseph.kogut@gmail.com (Joseph Kogut)
Date: Sun, 23 Jul 2017 10:03:00 -0700
Subject: [PATCH] ARM64: meson-gxl: disable broken eee
In-Reply-To: <7ho9scsdbp.fsf@baylibre.com>
References: <20170707013257.18250-1-joseph.kogut@gmail.com>
 <7ho9scsdbp.fsf@baylibre.com>
Message-ID: <CAMWSM7hB1e8gJEY3RvQ6UyWsZC0qB-rV2PTxun_4mdzO0e8X-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

I tested on a P212 reference board, which is currently the only GXL
based board I have.

Before applying the patch, high activity on the ethernet interface
would cause the link to break, requiring the interface to be brought
down and back up before it would work again. After applying the patch,
I could not get the link to break with any transfers.
