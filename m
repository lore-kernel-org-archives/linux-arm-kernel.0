From: vw@iommu.org (Wan Zongshun)
Date: Fri, 15 Jan 2016 15:53:41 +0800
Subject: [PATCH] mtd: nuc900_nand: read correct SMISR register
In-Reply-To: <4251392.DUmfQyrPag@wuerfel>
References: <9019174.GYajdpGP8V@wuerfel> <20160114002900.GA54220@google.com>
 <56976BA9.2040709@iommu.org> <4251392.DUmfQyrPag@wuerfel>
Message-ID: <5698A585.7060007@iommu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>>
>> Actually, Nuvoton should still leverage this upstream w90x900 codes for
>> their old and new arm chip BSP, but I am not sure their open source plan
>> for the new chip now, I will check with Nuvoton for this topic, and give
>> you feedback here, so please hold on its removal.
>
> Ok, sure. Thanks for the quick reply!
>
> I've had a look around at the current produce lineup, and it seems that
> nuc900 (w90x900) is still marketed, and as you say is similar to the n329
> series.
>
> There has been one attempt to do a modern port for n329 in 2014 but
> it never got submitted. See http://comments.gmane.org/gmane.linux.kernel.kernelnewbies/49077
> and https://github.com/mpthompson/linux/tree/n329
>
> The code looks rather nice, so it's a pity that the effort stalled,
> but it should not be hard for anyone to start out with Mike's tree
> and forward-port it to 4.5.

I will try to get this board you mentioned and try to cowork Mike to 
submit it into upstream.

After checking with Nuvoton people, and I will get another board and 
help them update the latest kernel BSP and also submit new nuc970 chip 
BSP into upstream.

spec:
http://www.nuvoton.com/hq/products/microprocessors/arm9-mpus/nuc900-series/?__locale=en

>
> 	Arnd
>
