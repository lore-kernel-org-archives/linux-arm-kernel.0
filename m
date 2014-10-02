From: orsonzhai@gmail.com (Orson Zhai)
Date: Thu, 02 Oct 2014 23:08:35 +0800
Subject: [PATCH 1/6] Documentation: DT: Add bindings for Spreadtrum serial
In-Reply-To: <20141001112149.GA13759@leverpostej>
References: <1411992293-7729-1-git-send-email-zhang.lyra@gmail.com>
 <1411992293-7729-2-git-send-email-zhang.lyra@gmail.com>
 <20141001112149.GA13759@leverpostej>
Message-ID: <542D6A73.9020505@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 2014?10?01? 19:21, Mark Rutland wrote:
>> diff --git a/Documentation/devicetree/bindings/serial/of-serial.txt b/Documentation/devicetree/bindings/serial/of-serial.txt
>> >index 7705477..a0bb1d1 100644
>> >--- a/Documentation/devicetree/bindings/serial/of-serial.txt
>> >+++ b/Documentation/devicetree/bindings/serial/of-serial.txt
>> >@@ -14,6 +14,7 @@ Required properties:
>> >  	- "altr,16550-FIFO32"
>> >  	- "altr,16550-FIFO64"
>> >  	- "altr,16550-FIFO128"
>> >+	- "sprd,serial"
> Is there not a more specific name? I'd imagine you might build a
> different uart in future.
AFAIK, sprd's uart is re-used the same ip core in ARM 32bit chip.
so it is neither 16550 or pl011 compatible.
>
> I didn't spot "sprd" in vendor-prefixes.txt in mainline. Is there a
> patch adding that?
sorry for missing it. we'll add it at patch V2.
thanks for reviewing! :)
>
> Mark.
>
