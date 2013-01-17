From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 17 Jan 2013 13:54:35 +0200
Subject: [PATCH 1/3] MTD: at91: atmel_nand: for PMECC, add code to
 choose the ecc bits and sector size according to the ONFI parameter ECC
 requirement.
In-Reply-To: <50F664BC.7@atmel.com>
References: <1355912840-29501-1-git-send-email-josh.wu@atmel.com>
 <1355912840-29501-2-git-send-email-josh.wu@atmel.com>
 <1358252760.2731.133.camel@sauron.fi.intel.com> <50F664BC.7@atmel.com>
Message-ID: <1358423675.2731.232.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-01-16 at 16:28 +0800, Josh Wu wrote:
> Hi, Artem
> 
> On 1/15/2013 8:26 PM, Artem Bityutskiy wrote:
> > I cannot compile this patch:
> >
> > ERROR (phandle_references): Reference to non-existent node or label "pinctrl_ssc0_tx"
> >
> > ERROR: Input tree has errors, aborting (use -f to force output)
> > make[2]: *** [arch/arm/boot/dts/at91sam9g20ek.dtb] Error 2
> 
> As Bo Shen already mentioned, they are caused by ssc pinctrl patches. it 
> will be merged in next rc or late.

Then ping me when the patches are ready to go, please.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130117/18bb67c3/attachment.sig>
