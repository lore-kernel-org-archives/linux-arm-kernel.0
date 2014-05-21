From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 21 May 2014 18:17:10 +0300
Subject: [PATCH 0/6] AM43xx & OMAP5 DSS DT changes
In-Reply-To: <20140521150231.GH17417@atomide.com>
References: <1400676625-30078-1-git-send-email-tomi.valkeinen@ti.com>
 <20140521150231.GH17417@atomide.com>
Message-ID: <537CC376.5050501@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/05/14 18:02, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [140521 05:51]:
>> Hi,
>>
>> Here are the AM43xx and OMAP5 display DT changes again. I've sent the clock
>> related changes separately, and I removed OMAP5's RFBI node, which depends on
>> more clock changes. The RFBI driver doesn't work at the moment anyway, so
>> removing the RFBI node should not be an issue.
>>
>> Tony, if these look fine (the rfbi change is the only one compared to the
>> previous versions), can you queue them for 3.16?
> 
> Probably best that you do a late branch again after arm-soc dts changes
> have been merged. Sounds like you have at least that macro dependency
> to omap-for-v3.16/dt-v2 so you should probably base your branch on

There are no dependencies that I know of. Which macro dependency is that?

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140521/6b68bd54/attachment-0001.sig>
