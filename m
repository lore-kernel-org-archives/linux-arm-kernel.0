From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 17 Mar 2014 12:30:02 +0200
Subject: [PATCH v15][ 2/3] video: imxfb: Add DT default contrast control
 register property.
In-Reply-To: <1394794553-14719-2-git-send-email-denis@eukrea.com>
References: <1394794553-14719-1-git-send-email-denis@eukrea.com>
 <1394794553-14719-2-git-send-email-denis@eukrea.com>
Message-ID: <5326CEAA.9090209@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/03/14 12:55, Denis Carikli wrote:
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Acked-by: Grant Likely <grant.likely@linaro.org>
> ---
> ChangeLog v14->v15:
> - Moved the Cc into git send-email.
> - Rebased.
> 
> ChangeLog v5->v14:
> - Remove people not concerned by this patch from the Cc list.
> - Changed the property name to match the register name and function.
> - Updated the documentation, code and commit message accordingly.
> ---
>  .../devicetree/bindings/video/fsl,imx-fb.txt       |    3 +++
>  drivers/video/fbdev/imxfb.c                        |    3 +++
>  2 files changed, 6 insertions(+)

Queued for 3.15.

 Tomi



-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140317/8f94363c/attachment.sig>
