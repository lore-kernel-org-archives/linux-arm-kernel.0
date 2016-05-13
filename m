From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 13 May 2016 09:48:23 +0200
Subject: [PATCHv2] devicetree: sunxi: Add OLinuXino Lime2 eMMC to the
 Makefile
In-Reply-To: <1463047851-2039-1-git-send-email-oliver@schinagl.nl>
References: <1463047851-2039-1-git-send-email-oliver@schinagl.nl>
Message-ID: <20160513074823.GA3733@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olliver,

On Thu, May 12, 2016 at 12:10:51PM +0200, Olliver Schinagl wrote:
> commit 27dd9af6bc (ARM: dts: sunxi: Add a olinuxino-lime2-emmc added the new
> emmc equipped) lime2 but forgot its Makefile.

This is still not the right commit format, the commit title should be
around double quotes. checkpatch both reports an error for this and
tells you what the proper format is, so please remember to use it
before you're sending a patch.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160513/401ee930/attachment.sig>
