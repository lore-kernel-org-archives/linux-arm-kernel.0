From: sre@kernel.org (Sebastian Reichel)
Date: Sun, 21 Feb 2016 20:18:18 +0100
Subject: [PATCH] ARM: dts: omap3-n900: Allow gpio keys to be disabled
In-Reply-To: <56C9F8AA.9080503@gmail.com>
References: <1452447990-22775-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160212215326.GD19432@atomide.com> <56C9F8AA.9080503@gmail.com>
Message-ID: <20160221191818.GB15242@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ivo,

On Sun, Feb 21, 2016 at 07:49:30PM +0200, Ivaylo Dimitrov wrote:
> On 12.02.2016 23:53, Tony Lindgren wrote:
> >Looks like this no longer applies because of linux,can-disable
> >to wakeup-source changes. Can you please update against v4.5-rc
> >series and repost?
> 
> Could you elaborate on that? As I don't really understand what needs to be
> updated and what are "wakeup-source changes".

Due to changes in the kernel source  (each gpio key in omap3-n900.dts
gained a "wakeup-source" property) the patch can no longer be applied
using "git am". Just rebase your patch to current 4.5-rc and resend it.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160221/c2614b30/attachment.sig>
