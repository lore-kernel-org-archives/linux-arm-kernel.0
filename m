From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Mon, 19 Nov 2012 13:17:59 +0100
Subject: [PATCH v2 1/4] mfd: tps65217: Set PMIC to shutdowm on PWR_EN
 toggle
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA760FD@DBDE01.ent.ti.com>
 (Chimata AnilKumar's message of "Mon, 19 Nov 2012 11:36:57 +0000")
References: <1353067706-29491-1-git-send-email-anilkumar@ti.com>
 <1353067706-29491-2-git-send-email-anilkumar@ti.com>
 <87a9udn9xo.fsf@dell.be.48ers.dk>
 <331ABD5ECB02734CA317220B2BBEABC13EA760FD@DBDE01.ent.ti.com>
Message-ID: <87r4nplrbc.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "A" == AnilKumar, Chimata <anilkumar@ti.com> writes:

Hi,

 >> I don't feel this property name is very clear. Perhaps something about
 >> power button or push button monitor as it is called in the datasheet?

 A> Here I am writing "TPS65217_STATUS_OFF" to status register, BIT(7).
 A> Description of this bit field: "OFF bit. Set this bit to 1 to enter
 A> OFF state when PWR_EN pin is pulled low. Bit is automatically reset
 A> to 0."

 A> PWR_EN pin pull-down is doing by RTC module.

Ahh yes, sorry -ENOCOFFEE. I somehow misread the datasheet and looked at
bit 0 instead.

-- 
Bye, Peter Korsgaard
