From: s.peter@mpl.ch (Stefan Peter)
Date: Thu, 27 Dec 2012 23:22:47 +0100
Subject: [PATCH v2 13/20] arm: kirkwood: mplcec4: use Device Tree to probe
 SDIO
In-Reply-To: <20121227164544.GW21694@titan.lakedaemon.net>
References: <1356101359-6054-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1356101359-6054-14-git-send-email-thomas.petazzoni@free-electrons.com>
 <50DC3FC0.4000308@mpl.ch> <20121227164544.GW21694@titan.lakedaemon.net>
Message-ID: <50DCCA37.70603@mpl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason

On 27.12.2012 17:45, Jason Cooper wrote:
> On Thu, Dec 27, 2012 at 01:32:00PM +0100, Stefan Peter wrote:
>> on 21.12.2012 15:49, Thomas Petazzoni wrote:
>>> Now that the mvsdio driver has a Device Tree binding, and the SDIO
>>> controller is declared in kirkwood.dtsi, migrate the mplcec4 board to
>>> use the Device Tree to probe the SDIO controller and to mux the pins
>>> of the SDIO interface correctly.
>>>
>>> This patch has not been tested, it remains to be tested by a person
>>> having access to the hardware.
>>>
>>> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>>> Cc: Stefan Peter <s.peter@mpl.ch>
> ...
>> After applying "Fixes for 3.8-rc1" and"ARM: Kirkwood: Fix missing clk
>> for USB device" from Andrew to 3.8-rc1, I was able to test these patches
>> on the MPL CEC4 under 3.8-rc1. The mvsdio was fully functional.
> 
> If you are comfortable saying so, please add a "Tested-by: ..." We don't
> like to assume ;-)
> 

I will do so as soon as I don't need two additional patches to get it
working. However, if you are interested in getting a Tested-by for the
"Fixes for 3.8-rc1" and"ARM: Kirkwood: Fix missing clk for USB device"
from Andrew, let my know.

Regards

Stefan Peter


-- 
MPL AG, Switzerland                     http://www.mpl.ch
Tel. +41 (0)56 483 34 34          Fax: +41(0)56 493 30 20
