From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Thu, 27 Feb 2014 18:23:55 +0100
Subject: [PATCH 0/8] OMAP: OMAP3 DSS related clock patches
In-Reply-To: <1392285846-13199-1-git-send-email-tomi.valkeinen@ti.com>
References: <1392285846-13199-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <530F74AB.5030109@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomi,

On 02/13/2014 11:03 AM, Tomi Valkeinen wrote:
> Hi,
> 
> I've been debugging OMAP3 related issues with DSS clocks, and I hopefully have
> them all fixed with this series. This fixes the problems for both non-DT boot,
> but also for DT boot with DSS DT support (which is not merged yet).
> 
> The non-DT boot related fixes should be merged for 3.14, but I'd like the DT
> boot related fixes to be merged for 3.14 also, as that'll make handling the DSS
> DT support easier.
> 

I hit this issue when developing on top of 3.14-rc4, the DSS failed to
set fck. Your patches made the Overo (both OMAP35xx and OMAP36xx) to get
a working DVI output when booting via DT. And the board did not catch on
fire, contrary to what Mike hopped :)

Tested-by: Florian Vaussard <florian.vaussard@epfl.ch>
