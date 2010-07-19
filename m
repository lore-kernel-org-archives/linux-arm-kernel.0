From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 19 Jul 2010 09:29:25 +0900
Subject: [PATCH 2/3] ARM: S5PV210: Add support for I2C devices on SMDKV210
	and SMDKC110
In-Reply-To: <AANLkTikK6qjh4yG5OX8g8Ih22SCg-2m3nUIfMDABHChf@mail.gmail.com>
References: <1279285999-27555-1-git-send-email-kgene.kim@samsung.com>
	<1279285999-27555-3-git-send-email-kgene.kim@samsung.com>
	<AANLkTikK6qjh4yG5OX8g8Ih22SCg-2m3nUIfMDABHChf@mail.gmail.com>
Message-ID: <000201cb26d9$7472a420$5d57ec60$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> On Fri, Jul 16, 2010 at 10:13 PM, Kukjin Kim <kgene.kim@samsung.com>
wrote:
> > From: Naveen Krishna Ch <ch.naveen@samsung.com>
> >
> > This patch adds support I2C-0/1/2 devices to the SMDKV210/SMDKC110.
> >
> > Signed-off-by: Naveen Krishna Ch <ch.naveen@samsung.com>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---
> > ?arch/arm/mach-s5pv210/Kconfig ? ? ? ? | ? ?8 ++++++++
> > ?arch/arm/mach-s5pv210/mach-smdkc110.c | ? 28
> ++++++++++++++++++++++++++++
> > ?arch/arm/mach-s5pv210/mach-smdkv210.c | ? 29
> +++++++++++++++++++++++++++++
> > ?3 files changed, 65 insertions(+), 0 deletions(-)
> >

(snip)

> >
> > +static struct i2c_board_info smdkc100_i2c_devs0[] __initdata = {
> > + ? ? ? { I2C_BOARD_INFO("24c08", 0x50), }, ? ? /* Samsung S524AD0XD1 */
> > +};
> > +
> 
> why smdkc100?
> 
Oh,...thank you for pointing out..will fix it.

> > +static struct i2c_board_info smdkc100_i2c_devs1[] __initdata = {
> > + ? ? ? /* To Be Updated */
> > +};
> > +
> Ditto
> 
> > +static struct i2c_board_info smdkc100_i2c_devs2[] __initdata = {
> > + ? ? ? /* To Be Updated */
> > +};
> Ditto
> 

(snip)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
