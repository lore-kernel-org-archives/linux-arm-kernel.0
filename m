From: nm@ti.com (Nishanth Menon)
Date: Wed, 7 Oct 2015 15:40:16 -0500
Subject: [PATCH] ARM: configs: keystone: Add ramdisk support
In-Reply-To: <5615812B.2010904@oracle.com>
References: <1444246089-1417-1-git-send-email-nm@ti.com>
 <12772658.mmM2ZKnfR4@wuerfel> <561578F0.80809@ti.com>
 <5615812B.2010904@oracle.com>
Message-ID: <56158330.7020107@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/2015 03:31 PM, santosh shilimkar wrote:
> Nishant,
> 
> On 10/7/2015 12:56 PM, Nishanth Menon wrote:
>> On 10/07/2015 02:37 PM, Arnd Bergmann wrote:
>>> On Wednesday 07 October 2015 14:28:09 Nishanth Menon wrote:
>>>> Add ramdisk support to allow for minimal kernel to be supported.
>>>>
>>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>>>
>>>
>>> I have not seen that in a while. Can you explain why the normal
>>> initramfs method doesn't work on keystone?
>>
>> It probably does - I have'nt used it - i am using an initrd thanks to
>> legacy testing support framework I am stuck with. The SoC I am
>> attempting to bring up has no support (yet) for any storage device for
>> filesystem yet.
>>
> If not checked already, please check with Vitaly.

I suppose the message is no initrd.. OK. will drop this patch.


-- 
Regards,
Nishanth Menon
