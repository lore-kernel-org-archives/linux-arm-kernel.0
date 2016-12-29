From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 29 Dec 2016 21:40:00 -0200
Subject: [PATCH v1] watchdog: imx2: fix hang-up on boot for i.MX21, i.MX27
 and i.MX31 SoCs
In-Reply-To: <20161229220445.x23gcp5aaw2fz7cv@pengutronix.de>
References: <20161223083256.3wdqou5xmhr7fidn@pengutronix.de>
 <74751709-c32e-b1b3-4fa3-613f7d57d1d8@mleia.com>
 <20161223100113.s57bi7257yero7f7@pengutronix.de>
 <7018c466-2467-a9fc-2382-889d3a62741e@mentor.com>
 <20161223141139.rlsvoonih5lhnnpu@pengutronix.de>
 <c22600d5-f6b5-4c13-59b4-ba391ea29a4c@mleia.com>
 <20161228205419.la74jr4rfes7fa4v@pengutronix.de>
 <CAOMZO5BD3Y6vXwt7_bdv_KyGvKSYru1vzDowsD81fzEbM4gHPA@mail.gmail.com>
 <20161228214651.oncshkvksqep3krk@pengutronix.de>
 <CAOMZO5CBfiRMicxvGyHrm-rQFzn8yEQyb5=t49PBr6rdpZYPug@mail.gmail.com>
 <20161229220445.x23gcp5aaw2fz7cv@pengutronix.de>
Message-ID: <CAOMZO5CuUM3e9LRZCV4NprzCxR2d=XCib013=YUdL0qQnNA2nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 29, 2016 at 8:04 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:

> Ack. If you teach the driver now about i.MX35 and only make use of the WMCR
> register on this one, the possible breakage is that this register isn't
> written to on the i.MX35 type until the dtb is updated.

So basically you are saying that you don't care about old dtb compatibility.

As far as I can see this is the reason we have not made any progress
with this patch since September.
