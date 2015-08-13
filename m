From: balbi@ti.com (Felipe Balbi)
Date: Thu, 13 Aug 2015 10:01:14 -0500
Subject: [PATCH-next 2/4] arm: boot: dts: am4372: add ARM timers and SCU
 nodes
In-Reply-To: <20150813083215.GY4215@atomide.com>
References: <1439409416-32673-1-git-send-email-balbi@ti.com>
 <1439409416-32673-3-git-send-email-balbi@ti.com>
 <20150813083215.GY4215@atomide.com>
Message-ID: <20150813150114.GH27560@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 13, 2015 at 01:32:15AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [150812 13:00]:
> > AM437x devices sport SCU, TWD and Global timers,
> > let's add them to DTS so they have a chance to
> > probe and be used by Linux.
> 
> Applying this one into omap-for-v4.3/dt-v2. Not sure
> if it will get merged as we're getting close to the
> merge window. The rest we can patch once Russell has
> reverted the bogus SMP dependency.

I'm just waiting for Russell's "it's okay to post on patch system".

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150813/a9e68a66/attachment-0001.sig>
