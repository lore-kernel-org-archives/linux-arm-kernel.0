From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 25 Jul 2012 20:59:24 +0400
Subject: [PATCH v2 6/6] arm/dts: am33xx rtc node
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9AD8B1@DBDE01.ent.ti.com>
References: <cover.1343191280.git.afzal@ti.com>
 <d16976055462214af276d7242faa2bc6e621fd44.1343191280.git.afzal@ti.com>
 <500FD698.30906@mvista.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9AD8B1@DBDE01.ent.ti.com>
Message-ID: <501025EC.6010600@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07/25/2012 06:09 PM, Mohammed, Afzal wrote:

>>> +		rtc at 44e3e000 {

>>     Address postfix in the node name without "reg" property?

> As per [1], "The unit-address is included if the node describes
> a device with an address".

   Which in this case it doesn't.

> Here even though reg property is not present, as via hwmod
> (see below) it is getting address, isn't it better to have it

   I think not.

>>> +			compatible = "ti,da830-rtc";
>>> +			ti,hwmods = "rtc";

WBR, Sergei
