From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 1 Dec 2017 18:17:38 -0200
Subject: [PATCH 4/8] ARM: dts: imx7s: add dma support
In-Reply-To: <20171130201434.14122-5-tyler@opensourcefoundries.com>
References: <20171130201434.14122-1-tyler@opensourcefoundries.com>
 <20171130201434.14122-5-tyler@opensourcefoundries.com>
Message-ID: <CAOMZO5BVK=KHJ7ohdCE=LRpo25FrM9d_vGSTm-GFpM6=wyvbuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 30, 2017 at 6:14 PM,  <tyler@opensourcefoundries.com> wrote:
> From: Tyler Baker <tyler@opensourcefoundries.com>
>
> Enable dma on all SPI and UART interfaces.

You only touched SPI ports, not the UART.
