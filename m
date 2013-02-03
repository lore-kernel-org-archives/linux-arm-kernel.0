From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 3 Feb 2013 21:43:20 +0800
Subject: Question: Way to add missing pads & pins into pinctrl driver
In-Reply-To: <1359638150.473297558@f28.mail.ru>
References: <1359638150.473297558@f28.mail.ru>
Message-ID: <20130203134318.GB24081@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 05:15:50PM +0400, Alexander Shiyan wrote:
> Hello.
> 
> I have found some missing pads and pins definitions in the pinctrl-imx51 driver.
> Appending in sort order will break current devicetree configurations, so I want
> to know better way for add these definitions. Of course I can just append
> at the end, but this will break sort order. How to do it better?

They will have to be added at the end.

But that big array defining a bunch of data of pad really gives me
a headache whenever I have a new SoC support to be added.  I will be
working on moving all these data over into device tree, hopefully soon.

Shawn
