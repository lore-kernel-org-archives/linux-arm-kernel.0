From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 26 Sep 2016 07:34:19 +0300
Subject: [RFC PATCH 2/2] ARM: i.MX: dts: add fsl, imx25-wdt compatible to
 all relevant watchdog nodes
In-Reply-To: <1474850361-20884-3-git-send-email-vz@mleia.com>
References: <1474850361-20884-1-git-send-email-vz@mleia.com>
 <1474850361-20884-3-git-send-email-vz@mleia.com>
Message-ID: <20160926043419.wljnbmopmfy4kor4@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On Mon, Sep 26, 2016 at 03:39:21AM +0300, Vladimir Zapolskiy wrote:
> Watchdog device controller found on all modern SoCs from i.MX series
> and firstly introduced in i.MX25 is not one in one compatible with the
> watchdog controllers on i.MX21, i.MX27 and i.MX31, the latter
> controlles don't have WICR (and pretimeout notification support) and
> WMCR registers. To get benefit from the more advanced watchdog device
> and to avoid operations over non-existing registers on legacy SoCs add
> fsl,imx25-wdt compatible to descriptions of all i.MX25 compatible
> watchdog controllers.

Maybe also update Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt? 
In a separate patch.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
