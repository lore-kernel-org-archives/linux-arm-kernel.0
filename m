From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Tue, 29 Jan 2013 17:39:02 +0530
Subject: [PATCH 2/2] drivers: net:ethernet: cpsw: add support for VLAN
In-Reply-To: <1359452926.4336.1.camel@coredoba.hi.pengutronix.de>
References: <1359403945-28585-1-git-send-email-mugunthanvnm@ti.com>
 <1359403945-28585-3-git-send-email-mugunthanvnm@ti.com>
 <1359452926.4336.1.camel@coredoba.hi.pengutronix.de>
Message-ID: <5107BBDE.7030401@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/29/2013 3:18 PM, Jan L?bbe wrote:
> On Tue, 2013-01-29 at 01:42 +0530, Mugunthan V N wrote:
>> --- a/Documentation/devicetree/bindings/net/cpsw.txt
>> +++ b/Documentation/devicetree/bindings/net/cpsw.txt
>> @@ -24,6 +24,8 @@ Required properties:
>>   Optional properties:
>>   - ti,hwmods            : Must be "cpgmac0"
>>   - no_bd_ram            : Must be 0 or 1
>> +- default_vlan         : Specifies Default VLAN for non tagged packets
>> +                         ALE processing
> This does not seem to be a property of the hardware. Could there be a
> reasonable default for it?
>
> Regards,
> Jan
Jan

In VLAN aware mode, ALE always process only VLAN tagged packets. Even 
untagged packets
In hardware you can use any VLAN id for default (non tagged packet) 
filtering.

Regards
Mugunthan V N
