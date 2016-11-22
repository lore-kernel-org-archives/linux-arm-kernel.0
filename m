From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 22 Nov 2016 09:43:16 -0600
Subject: [PATCH v2] ARM: dts: AM571x-IDK Initial Support
In-Reply-To: <20161122041732.8385-1-lokeshvutla@ti.com>
References: <20161122041732.8385-1-lokeshvutla@ti.com>
Message-ID: <CAL_JsqLv2t0qzJ1V6NGPj3iy9tOmMcnr3nsHxojb9aJxp9+8BQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2016 at 10:17 PM, Lokesh Vutla <lokeshvutla@ti.com> wrote:
> From: Schuyler Patton <spatton@ti.com>
>
> The AM571x-IDK board is a board based on TI's AM5718 SOC
> which has a single core 1.5GHz A15 processor. This board is a
> development platform for the Industrial market with:
> - 1GB of DDR3L
> - Dual 1Gbps Ethernet
> - HDMI,
> - PRU-ICSS
> - uSD
> - 16GB eMMC
> - CAN
> - RS-485
> - PCIe
> - USB3.0
> - Video Input Port
> - Industrial IO port and expansion connector
>
> The link to the data sheet and TRM can be found here:
>
> http://www.ti.com/product/AM5718
>
> Initial support is only for basic peripherals.
>
> Signed-off-by: Schuyler Patton <spatton@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
> Cahnges since v1:
> - Dropped "ti,dra722", and "ti,dra72" from compatibles
> - Fixes few node names as suggested by Rob.
> Logs: http://pastebin.ubuntu.com/23515001/

Please add acks when posting new versions.

Rob
