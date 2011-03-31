From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 31 Mar 2011 15:09:53 +0300
Subject: [PATCH] mtd/mxc_nand: add support for multiple chips on V21
	devices
In-Reply-To: <2731521d2fd2224b7b28cc9ced044fc026d4fdb7.1300085993.git.baruch@tkos.co.il>
References: <2731521d2fd2224b7b28cc9ced044fc026d4fdb7.1300085993.git.baruch@tkos.co.il>
Message-ID: <1301573393.2828.51.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-03-14 at 09:01 +0200, Baruch Siach wrote:
> Do the following to add support for up to 4 chips on V21 devices (i.MX25 and
> i.MX35):
> 
> * implement .select_chip for V21
> * adjust existing NFC_V1_V2_BUF_ADDR writes to take chip select into account
> * unlock all chip selects at preset_v1_v2()
> * scan up to 4 devices at .probe
> 
> This has been tested on i.MX25 with two attached NAND chip (on one die).
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Pushed to l2-mtd-2.6.git, thank you.

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
