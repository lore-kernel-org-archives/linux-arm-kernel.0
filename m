From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 2 Nov 2017 10:15:47 +0100
Subject: [PATCH v2 0/3] arm64: defconfig: remove some Qualcomm USB options
In-Reply-To: <20171031125808.7300-1-elder@linaro.org>
References: <20171031125808.7300-1-elder@linaro.org>
Message-ID: <CAK8P3a0r8NZdbv8KYyF72oXU_3gxBD2ETzY+BZUf4i5V4Lr=mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 31, 2017 at 1:58 PM, Alex Elder <elder@linaro.org> wrote:
> This series deletes three config options related to USB on Qualcomm
> SoCs from the arm64 "defconfig".  The code enabled by the options is
> no longer needed by any Qualcomm hardware.  The driver code that
> corresponds to these config options is removed in a separate series.
>
>                                         -Alex
>
> v2:  Added Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

The patches look good. Should we apply them directly to arm-soc, or is
Andy going to forward them? Normally I'd wait for him to apply them,
but I see he has already given an Ack, so I don't know what to do here.

         Arnd
