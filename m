From: netz.kernel@gmail.com (Marty Plummer)
Date: Sat, 10 Sep 2016 19:47:50 -0500
Subject: [RFD] hix5hd2 datasheet?
In-Reply-To: <57D2740C.10000@hisilicon.com>
References: <dae6535c-13f2-7d79-d938-30b1a6fb4afc@gmail.com>
 <57D2740C.10000@hisilicon.com>
Message-ID: <37ac958a-2196-349d-6af9-995067f1bdb8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/09/2016 03:34 AM, Wei Xu wrote:
> Hi Marty,
> 
> On 08/09/2016 23:58, Marty Plummer wrote:
>> Hello,
>>
>> 	I'm currently working to get the ethernet interface for the
>> hi3520 SoC to work, and I think (emphasis on think) the hix5hd2-gmac
>> driver is compatible, or nearly so, as checking the sdk source code
>> for the interface has a fairly large amount of similar code (well, as
>> similar as 2.6.24 vs 4.8-rc4 code can be) and identical register
>> definitions to the very bit, so I was hoping to compare the datasheets
>> and see how far the commonality goes. Plus, having the datasheets
>> readily available will be of assistance to anyone else looking to
>> contribute.
> 
> +Jiancheng into this mail group.
> Maybe you could get the hix5hd2 datasheets from him.
> Thanks!
> 
> Best Regards,
> Wei
> 
>>
>> Thanks,
>> 	Marty
>>
>>
> 
In additon, I'm wondering how the second reg property for the
hix5hd2-gmac devicetree is determined (in fact, that is my main concern),
as I'm pretty sure it will work with the gmac on hi3520, but I can't
find a register in the hi3520 datasheet that I could 100% say is the
right one, and adding the driver to the initrd causes a kernel panic
(I'm assuming this is because of wrong reg values unless otherwise
proven) on an otherwise mostly working kernel.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160910/39d7b739/attachment.sig>
