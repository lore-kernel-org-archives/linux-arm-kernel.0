From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 26 Nov 2013 17:00:31 +0200
Subject: [PATCH -v2] fbdev: sh_mobile_meram: Fix defined but not used
 compiler warnings
In-Reply-To: <1510041.WqZSiK0jXs@avalon>
References: <1383728247-19294-1-git-send-email-geert@linux-m68k.org>
 <5204468.CmggZzW3kO@avalon> <5294B3B9.3090104@ti.com>
 <1510041.WqZSiK0jXs@avalon>
Message-ID: <5294B78F.3010903@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-11-26 16:58, Laurent Pinchart wrote:
> Hi Tomi,
> 
> On Tuesday 26 November 2013 16:44:09 Tomi Valkeinen wrote:
>> On 2013-11-06 13:57, Laurent Pinchart wrote:
>>> On Wednesday 06 November 2013 09:57:27 Geert Uytterhoeven wrote:
>>>> If both CONFIG_PM_SLEEP and CONFIG_PM_RUNTIME are not set:
>>>>
>>>> drivers/video/sh_mobile_meram.c:573: warning: ?sh_mobile_meram_suspend?
>>>> defined but not used drivers/video/sh_mobile_meram.c:597: warning:
>>>> ?sh_mobile_meram_resume? defined but not used
>>>>
>>>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>>
>>> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>>
>>> and applied to my tree.
>>
>> What does that mean? Are you collecting sh_mobile video patches?
>>
>> Or to rephrase, shall I apply this to fbdev fixes tree?
> 
> I was planning to send you a pull request for that, but if you can pick it up 
> that's even easier, thanks.

Ok. Applied, then, to fbdev =).

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131126/89bb7bcc/attachment.sig>
