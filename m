From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 12 May 2014 16:25:41 +0300
Subject: [PATCH 00/11] ARM: OMAP: OMAP5 & AM43x DSS
In-Reply-To: <1399636579-8062-1-git-send-email-tomi.valkeinen@ti.com>
References: <1399636579-8062-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <5370CBD5.3060107@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On 09/05/14 14:56, Tomi Valkeinen wrote:
> Hi,
> 
> Here are arch/arm/ patches to add display support for OMAP5 and AM43x.
> 
> I have these in my tree, in a branch I will send to Tony for merging. Most of
> these patches have already been around the lists, but I wanted to send them one
> more time to verify that all looks right and everybody is fine with them.

I have pushed these to:

git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git 3.16/omap

If you're fine with these, I think we can consider that branch stable.
There are probably still a few display related .dts changed for the
board coming up, but I'll add those on top of the current commits.

I also have pushed OMAP5 and AM43xx related OMAPDSS patches to my
for-next branch, so with "3.16/omap" branch and linux-next, the omap5
and am43xx displays should be functional.

How do you want to handle getting the 3.16/omap branch to linux-next?
Will you take "ownership" of the branch, and push it to linux-next?

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140512/0e26df26/attachment.sig>
