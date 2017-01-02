From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Mon, 2 Jan 2017 19:01:22 +0100
Subject: [PATCH 2/9] ARM: dts: omap3: Add an empty chosen node to top
 level DTSI
In-Reply-To: <1482158681-4530-3-git-send-email-javier@osg.samsung.com>
References: <1482158681-4530-1-git-send-email-javier@osg.samsung.com>
 <1482158681-4530-3-git-send-email-javier@osg.samsung.com>
Message-ID: <201701021901.22476@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 December 2016 15:44:34 Javier Martinez Canillas wrote:
> Commit 008a2ebcd677 ("ARM: dts: omap3: Remove skeleton.dtsi usage")
> removed the skeleton.dtsi usage since we want to get rid of it.
> 
> But this can cause issues when booting a kernel with a boot-loader
> that doesn't create a chosen node if this isn't present in the DTB
> since the decompressor relies on a pre-existing chosen node to be
> available to insert the command line and merge other ATAGS info.
> 
> Fixes: 008a2ebcd677 ("ARM: dts: omap3: Remove skeleton.dtsi usage")
> Reported-by: Pali Rohar <pali.rohar@gmail.com>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Including empty chosen node fixes (or rather workaround) this problem. 
You can add my Tested-By.

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170102/310e22a8/attachment.sig>
