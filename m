From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 22 Feb 2013 15:58:49 +0800
Subject: [PATCH 2/3] ARM: dts: imx: replace magic number with pin
 function name
In-Reply-To: <20130221214303.GB1906@pengutronix.de>
References: <1361344089-16804-1-git-send-email-shawn.guo@linaro.org>
 <1361344089-16804-3-git-send-email-shawn.guo@linaro.org>
 <51251A11.2030300@wwwdotorg.org>
 <CAKGA1bkHH1XC38_VM=QhDrr33uqqSbwe0n+GfXEPs43K_Do=CQ@mail.gmail.com>
 <20130221050247.GD17738@S2101-09.ap.freescale.net>
 <CAKGA1bn22xctSj_33HQsWwnVB=RO2OJ=eYvgRD-kF+PiQcnC4Q@mail.gmail.com>
 <20130221214303.GB1906@pengutronix.de>
Message-ID: <20130222075848.GD27371@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 21, 2013 at 10:43:03PM +0100, Sascha Hauer wrote:
> This would leave the question how we make up a pin number for the
> pinctrl framework, but as said, this should be solved inside the kernel
> and not pushed into the devicetree.
> 
Ok, Dong has the same opinion to remove pin number from device tree,
I start working it out, and will roll out the new version.

Shawn
