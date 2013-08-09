From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 9 Aug 2013 08:27:03 -0300
Subject: [PATCH 1/1] ARM: dtsi: imx6qdl-sabresd: Add USB host 1 VBUS
 regulator
In-Reply-To: <20130809080540.GA23876@shlinux1.ap.freescale.net>
References: <1376007824-16325-1-git-send-email-peter.chen@freescale.com>
 <CAOMZO5AXprz7MsxmyWB_nH8pc0GX3sbcZUtDqEVkf0W9myBbxA@mail.gmail.com>
 <20130809080540.GA23876@shlinux1.ap.freescale.net>
Message-ID: <CAOMZO5BfLTG-8QAou-=m+bM_JL79wv_exedRbbh3hgB12WBWtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 9, 2013 at 5:05 AM, Peter Chen <peter.chen@freescale.com> wrote:

> Thanks, Fabio. What's the rule for adding gpio function for pinctrl
> at dts? At pinctrl_hog or the device's pinctrl group?

pinctrl_hog, as each board may have a different gpio to turn on the regulator.

The pinctrl group is used for group of pins that control a peripheral,
such as spi, uart, mmc, etc.
