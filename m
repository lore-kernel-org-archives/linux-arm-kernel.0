From: cphealy@gmail.com (Chris Healy)
Date: Wed, 19 Sep 2018 07:44:41 -0700
Subject: [PATCH 1/2] ARM: dts: imx51-zii-rdu1: Fix the rtc compatible
 string
In-Reply-To: <1537271012-5159-1-git-send-email-festevam@gmail.com>
References: <1537271012-5159-1-git-send-email-festevam@gmail.com>
Message-ID: <CAFXsbZo+VoGQy5aKg=_zFCgN54NU-ZaQhgqcRSgSDXtVaF2_zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> According to Documentation/devicetree/bindings/rtc/rtc-ds1307.txt the
> original compatible "maxim,ds1341" is not a valid entry.
>
> Switch to the documented "dallas,ds1341" compatible.

Tested-by: Chris Healy <cphealy@gmail.com>
