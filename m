From: daniel@zonque.org (Daniel Mack)
Date: Wed, 14 Nov 2018 20:58:00 +0100
Subject: [PATCH] ARM: dts: pxa3xx: add gcu node
In-Reply-To: <87muqgll3u.fsf@belgarion.home>
References: <20181105191827.3860-1-daniel@zonque.org>
 <87muqgll3u.fsf@belgarion.home>
Message-ID: <c4ea09bc-93b5-49f6-9059-a74dcdbc59a6@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

On 10/11/2018 9:43 PM, Robert Jarzmik wrote:
> Daniel Mack <daniel@zonque.org> writes:
> 
>> Add a device node for hardware graphic acceleration.
>>
>> Signed-off-by: Daniel Mack <daniel@zonque.org>
> Hi Daniel,
> 
>> +	gcu: display-controller at 54000000 {
>> +		compatible = "marvell,pxa300-gcu";
> Isn't every IP devicetree entry supposed to have a documentation in
> Documentation/devicetree going along a definition in the .dtsi files ?

Ah, that's already there, see cf925575d292b.

I did that when I taught the driver DT probing.


Thanks,
Daniel
