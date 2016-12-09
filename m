From: netz.kernel@gmail.com (Marty Plummer)
Date: Fri, 9 Dec 2016 09:07:55 -0600
Subject: [PATCH 1/3] arm: hisi: add ARCH_MULTI_V5 support
In-Reply-To: <2fcf5a5f-8935-c4f0-a034-c8a72dc2be0f@hisilicon.com>
References: <20161017120705.3726-1-wenpan@hisilicon.com>
 <20161017120705.3726-2-wenpan@hisilicon.com> <5893354.6MrIxqzRoI@wuerfel>
 <2fcf5a5f-8935-c4f0-a034-c8a72dc2be0f@hisilicon.com>
Message-ID: <fb89c03e-ea67-d339-b222-6f0e08988563@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/2016 08:03 PM, Jiancheng Xue wrote:
> Hi Arnd,
> 
> On 2016/10/17 21:48, Arnd Bergmann wrote:
>> On Monday, October 17, 2016 8:07:03 PM CEST Pan Wen wrote:
>>> Add support for some HiSilicon SoCs which depend on ARCH_MULTI_V5.
>>>
>>> Signed-off-by: Pan Wen <wenpan@hisilicon.com>
>>>
>>
>> Looks ok. I've added Marty Plummer to Cc, he was recently proposing
>> patches for Hi3520, which I think is closely related to this one.
>> Please try to work together so the patches don't conflict. It should
>> be fairly straightforward since you are basically doing the same
>> change here.
>>
> Marty hasn't give any replies about this thread until now. I reviewed
> the patch for Hi3520. And I think this patch won't conflict with Hi3520.
> Could you help us to ack this patch?
> 
> Thanks,
> Jiancheng
> 
> 
Hello all

Sorry for my lack of activity, I've just been very busy lately with real
world considerations (well, real world but related to this; I have
another board based on hi3521a I've been tinkering with, trying to get
the manuf. to release gpl source via the sfconfservancy). I've not given
up on the project, however, since devices like this really need updates
in light of the recent botnets targeting devices of this sort as
manpower.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161209/978fa980/attachment.sig>
