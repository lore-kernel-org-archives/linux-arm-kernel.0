From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 5 Jul 2012 17:23:47 +0300
Subject: [PATCH] i2c i.MX: Fix divider table
In-Reply-To: <1341493826-13861-1-git-send-email-s.hauer@pengutronix.de>
References: <1341493826-13861-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120705142347.GF2093@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Thu, Jul 05, 2012 at 03:10:26PM +0200, Sascha Hauer wrote:
> + * These values (mostly) do not match the ones in the datasheet because
> + * measurements have shown that the values are wrong. This was tested
> + * on i.MX1 and i.MX53, so it shoud be safe to assume that the SoCs in

s/shoud/should/

> + * between behave the same.
>   */

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
