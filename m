From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 02 Jan 2014 17:34:52 +0100
Subject: [RFC PATCH 3/3] i2c: mv64xxx: Document the newly introduced Armada
 XP A0 compatible
In-Reply-To: <20140101214552.GB19878@titan.lakedaemon.net>
References: <1388508293-9141-1-git-send-email-gregory.clement@free-electrons.com>
 <1388508293-9141-4-git-send-email-gregory.clement@free-electrons.com>
 <20140101214552.GB19878@titan.lakedaemon.net>
Message-ID: <52C5952C.5050707@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/01/2014 22:45, Jason Cooper wrote:
> [+ DT ml, Grant, Rob]
> 
> On Tue, Dec 31, 2013 at 05:44:53PM +0100, Gregory CLEMENT wrote:
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>  Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
>> index 82e8f6f17179..9410ed72ec45 100644
>> --- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
>> @@ -5,7 +5,7 @@ Required properties :
>>  
>>   - reg             : Offset and length of the register set for the device
>>   - compatible      : Should be "marvell,mv64xxx-i2c" or "allwinner,sun4i-i2c"
>> -                     or "marvell,mv78230-i2c"
>> +                     or "marvell,mv78230-i2c" or "marvell,mv78230-a0-i2c"
> 
> Once we nail down how we want to do this, Please add an explanation of
> the differences between the compatibles.  eg 'offloading broken'.
> 

Just to keep the DT mailing list, Grant and Rob in touch: I have
submitted an other series in which we don't have to use the device
tree to know the SoC revision. So if everything turns well we won't
have to apply this series.

If at the end we still need it, then I will add the explanation in
the next version.


Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
