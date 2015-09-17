From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 18 Sep 2015 00:42:40 +0200
Subject: [PATCH v2] ARM: dts: rockchip: Add dtb for the Radxa Rock 2
 Square board
In-Reply-To: <1442300242-510-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1442300242-510-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <2262570.nZrIWP6lhh@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sjoerd,

Am Dienstag, 15. September 2015, 08:57:21 schrieb Sjoerd Simons:
> The Radxa Rock 2 Square board is a combination of the Radxa Rock 2 SoM
> with the Square baseboard. Add a dtsi for the SoM which can be included
> into the dts for the various baseboards (e.g. full and square) and a dts
> for the square board.
> 
> Currently supported are serial console, wired networking, hdmi output,
> eMMC and SD storage and USB.
> 
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

applied to my dts32 branch for 4.4 with the following small changes:

- &vop{b/l}(_mmu) nodes only in the som.dtsi
  -> removed duplicates
- moved &tsadc and &wdt to alphabetical order


Heiko
