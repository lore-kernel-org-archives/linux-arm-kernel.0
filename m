From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 3 Jun 2015 14:53:33 +0300
Subject: [PATCH 2/4] video: fbdev: imxfb: Constify platform_device_id
In-Reply-To: <20150603115050.GB12304@x1>
References: <1430494721-30793-1-git-send-email-k.kozlowski.k@gmail.com>
 <1430494721-30793-2-git-send-email-k.kozlowski.k@gmail.com>
 <20150505082807.GV4047@x1> <556EE743.5030405@ti.com>
 <20150603115050.GB12304@x1>
Message-ID: <556EEABD.6020902@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/06/15 14:50, Lee Jones wrote:
> On Wed, 03 Jun 2015, Tomi Valkeinen wrote:
> 
>> Hi Lee,
>>
>> On 05/05/15 11:28, Lee Jones wrote:
>>> On Sat, 02 May 2015, Krzysztof Kozlowski wrote:
>>>
>>>> The platform_device_id is not modified by the driver and core uses it as
>>>> const.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
>>>> ---
>>>>  drivers/video/fbdev/imxfb.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> Applied, thanks.
>>
>> You applied the fbdev changes in this series also, not only the
>> backlight changes?
> 
> Ah, yes I did.  I assumed they were all due for Backlight.
> 
> Would you like me to un-apply the non-Backlight patches?

If you can easily remove them, yes.

But chances for conflict are quite minimal, so if you already have a
pile of commits on top of these, it's fine if they go via backlight tree.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150603/4f8a3b5b/attachment.sig>
