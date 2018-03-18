From: baruch@tkos.co.il (Baruch Siach)
Date: Sun, 18 Mar 2018 06:42:48 +0200
Subject: [PATCH net-next 05/10] phy: cp110-comphy: 2.5G SGMII mode
In-Reply-To: <20180316103351.16616-6-antoine.tenart@bootlin.com>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
 <20180316103351.16616-6-antoine.tenart@bootlin.com>
Message-ID: <20180318044247.kp3i2ymvrj5fdoj3@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,

On Fri, Mar 16, 2018 at 11:33:46AM +0100, Antoine Tenart wrote:
> This patch allow the CP100 comphy to configure some lanes in the

Should be 'CP110'.

> 2.5G SGMII mode. This mode is quite close to SGMII and uses nearly the
> same code path.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
