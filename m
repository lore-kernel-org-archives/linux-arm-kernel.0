From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed, 07 Jul 2010 12:15:26 +0300
Subject: pxa u2dc driver
In-Reply-To: <AANLkTilhY0hJ96TW5t2syRkdK8aQqINTuoNfaIcPVPMH@mail.gmail.com>
References: <1278428859.3657.387.camel@balakrishnan-desktop>
	<AANLkTilhY0hJ96TW5t2syRkdK8aQqINTuoNfaIcPVPMH@mail.gmail.com>
Message-ID: <4C3445AE.3060106@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/10 19:24, Eric Miao wrote:
> On Tue, Jul 6, 2010 at 11:07 PM, balakrishnan
> <balakrishnan@e-consystems.com> wrote:
>   
>> Hi,
>>   I am working on pxa300 based development board and using Linux
>> 2.6.34. In this usb 1.1 device controller driver support "pxa27x_udc" is
>> available but usb 2.0 device controller driver is not available. Any
>> patches is there for 2.6.34? or anybody tried for pxa3xx u2dc gadget?
>>
>>     
> The only available version at the moment is the one provided within Marvell's
> BSP. There is currently no support in mainline yet. Igor and Mike have been
> working on this for quite a time I think. There is not only the U2D controller
> itself, but also the ULPI interface support, and to complicate things
> a bit more,
> there is also a backward compatibility consideration for U2D + 1.1 Host to
> form a strange OTG solution.
>   

Just to clear things out.
We are working only on the host side functionality of the U2D and ULPI
drivers,
though keeping in mind future work (ours or anybody else) on the device
side functionality.


> I didn't look into that for a long time, but if you are interested in working on
> it, please let us know (Cc'ed Igor and Mike).
>   

Will be appreciated. Thanks.

>   
>> With Regards
>> J.Balakrishnan
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>>     
>   

-- 
Regards,
Igor.
