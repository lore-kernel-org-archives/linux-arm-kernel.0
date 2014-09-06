From: klightspeed@killerwolves.net (Ben Peddell)
Date: Sat, 06 Sep 2014 12:18:49 +1000
Subject: [PATCH] ARM: MVEBU: Netgear RN102: Use Hardware BCH ECC
In-Reply-To: <87ha0l23nt.fsf@natisbad.org>
References: <1409898233-9273-1-git-send-email-klightspeed@killerwolves.net>	<20140905154140.GA1377@arch.hh.imgtec.org>
 <87ha0l23nt.fsf@natisbad.org>
Message-ID: <540A6F09.9000605@killerwolves.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06 Sep 2014 at 06:49, Arnaud Ebalard wrote:
> FWIW, you can add my:
> 
>  Tested-by: Arnaud Ebalard <arno@natisbad.org>
>  
> Additionally, Ezequiel, would anything prevent pushing the patch to
> stable team (nand entry in .dts was added in 3.14):
> 
>  Fixes: 92beaccd8b49 ("ARM: mvebu: Enable NAND controller in ReadyNAS 102 .dts file")

Depends-on: 5b3e507820c6 ("mtd: nand: pxa3xx: Use ECC strength and step size devicetree binding")

The devicetree binding is not currently in linux-stable/linux-3.14.y
