From: balbi@ti.com (Felipe Balbi)
Date: Wed, 9 Jan 2013 17:07:57 +0200
Subject: [PATCH v2 1/5] ARM: OMAP2+: hwmod: add enable_preprogram hook
In-Reply-To: <1357743792-13917-2-git-send-email-s-guiriec@ti.com>
References: <1357743792-13917-1-git-send-email-s-guiriec@ti.com>
 <1357743792-13917-2-git-send-email-s-guiriec@ti.com>
Message-ID: <20130109150757.GL27133@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 09, 2013 at 04:03:07PM +0100, Sebastien Guiriec wrote:
> From: Paul Walmsley <paul@pwsan.com>
> 
> After setup/enable, some IP blocks need some additional setting to
> indicate the PRCM that they are inactive until they are configured.
> Some examples on OMAP4 include the AESS and FSUSB IP blocks.
> 
> To fix this cleanly, this patch adds another optional function
> pointer, setup_preprogram, to the IP block's hwmod data.  The function

the function pointer is called enable_preprogram.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130109/45c8d6c1/attachment.sig>
