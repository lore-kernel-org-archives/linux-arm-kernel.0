From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 28 Nov 2012 08:05:44 +0200
Subject: [PATCH] ARM: mx25_3ds: Add camera support
In-Reply-To: <1354022509-20505-1-git-send-email-fabio.estevam@freescale.com>
References: <1354022509-20505-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20121128060543.GA31335@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Tue, Nov 27, 2012 at 11:21:49AM -0200, Fabio Estevam wrote:
> mx25_3ds board has a OV2640 camera sensor.
> 
> Add support for it.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Good to see some activity on i.MX25 camera support. Did you test video capture 
with a latest kernel?  You have surely noticed that i.MX25 support in the 
mx2_camera driver is marked BROKEN since 087c78a8.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
