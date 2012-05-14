From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 14 May 2012 09:38:11 +0800
Subject: [PATCH 2/2 v7] ARM: pxa: hx4700: Add Synaptics NavPoint touchpad
In-Reply-To: <4fae49fa.921bd80a.6c62.3ffaSMTPIN_ADDED@mx.google.com>
References: <4fae49fa.921bd80a.6c62.3ffaSMTPIN_ADDED@mx.google.com>
Message-ID: <CAN1soZxLcSO0cTtV9uK0VqYGtVmjdbZKVwts9VXrGhdxAPwpfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 12, 2012 at 7:31 PM, Paul Parsons <lost.distance@yahoo.com> wrote:
> This patch adds the Synaptics NavPoint touchpad to the hx4700 platform:
> 1. Change GPIO23_SSP1_SCLK value in hx4700_pin_config[] from an output
> to an input, since the NavPoint is connected to SSP in SPI slave mode.
> 2. Add GPIO102_GPIO (NavPoint power) to hx4700_pin_config[].
> 3. Add navpoint platform_device to devices[].
>
> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
> Cc: Philipp Zabel <philipp.zabel@gmail.com>
> ---
>
Applied

Regards
Haojian
