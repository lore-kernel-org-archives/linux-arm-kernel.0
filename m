From: afzal@ti.com (Mohammed, Afzal)
Date: Wed, 25 Jul 2012 14:09:58 +0000
Subject: [PATCH v2 6/6] arm/dts: am33xx rtc node
In-Reply-To: <500FD698.30906@mvista.com>
References: <cover.1343191280.git.afzal@ti.com>
 <d16976055462214af276d7242faa2bc6e621fd44.1343191280.git.afzal@ti.com>
 <500FD698.30906@mvista.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9AD8B1@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Wed, Jul 25, 2012 at 16:50:56, Sergei Shtylyov wrote:

> > +		rtc at 44e3e000 {
> 
>     Address postfix in the node name without "reg" property?

As per [1], "The unit-address is included if the node describes
a device with an address".

Here even though reg property is not present, as via hwmod
(see below) it is getting address, isn't it better to have it

> 
> > +			compatible = "ti,da830-rtc";
> > +			ti,hwmods = "rtc";

Regards
Afzal


[1] http://devicetree.org/Device_Tree_Usage
