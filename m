From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 8 May 2014 13:31:59 +0300
Subject: [PATCH v7][ 1/5] video: mx3fb: Use devm_kzalloc
In-Reply-To: <1394788369-5096-1-git-send-email-denis@eukrea.com>
References: <1394788369-5096-1-git-send-email-denis@eukrea.com>
Message-ID: <536B5D1F.1090507@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/03/14 11:12, Denis Carikli wrote:
> Replace kzalloc by devm_kzalloc and remove the kfree() calls.
> 
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
> ChangeLog v6->v7:
> - Removed the Cc from the patch, they went into 
>   git send-email instead.
> ChangeLog v5->v6:
>  - New patch need
> ---
>  drivers/video/fbdev/mx3fb.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

I've picked this patch for 3.16. I didn't pick the DT related patches in
this series as there seemed to be unanswered questions about them.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140508/25a73595/attachment.sig>
