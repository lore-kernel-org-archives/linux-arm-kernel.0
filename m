From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 26 Nov 2013 16:44:09 +0200
Subject: [PATCH -v2] fbdev: sh_mobile_meram: Fix defined but not used
 compiler warnings
In-Reply-To: <5204468.CmggZzW3kO@avalon>
References: <1383728247-19294-1-git-send-email-geert@linux-m68k.org>
 <5204468.CmggZzW3kO@avalon>
Message-ID: <5294B3B9.3090104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On 2013-11-06 13:57, Laurent Pinchart wrote:
> Hi Geert,
> 
> Thank you for the patch.
> 
> On Wednesday 06 November 2013 09:57:27 Geert Uytterhoeven wrote:
>> If both CONFIG_PM_SLEEP and CONFIG_PM_RUNTIME are not set:
>>
>> drivers/video/sh_mobile_meram.c:573: warning: ?sh_mobile_meram_suspend?
>> defined but not used drivers/video/sh_mobile_meram.c:597: warning:
>> ?sh_mobile_meram_resume? defined but not used
>>
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> and applied to my tree.

What does that mean? Are you collecting sh_mobile video patches?

Or to rephrase, shall I apply this to fbdev fixes tree?

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131126/32fe24be/attachment.sig>
