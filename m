From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Wed, 18 Jun 2014 22:23:03 +0200
Subject: [PATCH] omap3-n900.dts: Rename model name to "Nokia RX-51 board"
In-Reply-To: <20140618201241.GB558@drone.musicnaut.iki.fi>
References: <1403110635-29696-1-git-send-email-pali.rohar@gmail.com>
 <20140618201241.GB558@drone.musicnaut.iki.fi>
Message-ID: <201406182223.03420@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 June 2014 22:12:41 Aaro Koskinen wrote:
> On Wed, Jun 18, 2014 at 06:57:15PM +0200, Pali Roh?r wrote:
> > Use same name as in legacy board code. There are lot of
> > userspace applications which using machine/model name for
> > determinating device type.
> 
> Can you clarify this? Nokia kernel or userspace never had DT,
> so they cannot see e.g. /proc/device-tree/model. What other
> APIs expose model?
> 
> A.

Hi Aaro,

look at email discussion about my previous patch with subject:
[PATCH] ARM: /proc/cpuinfo: Use DT machine name when possible

Basically that patch export model name in Hardware /proc/cpuinfo 
instead generic DT name. And this patch change name to what 
legacy board code reported.

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140618/2d166566/attachment.sig>
