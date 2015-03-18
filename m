From: balbi@ti.com (Felipe Balbi)
Date: Wed, 18 Mar 2015 09:40:35 -0500
Subject: [PATCH 3/4] ARM: dts: Add cppi41 support for dm816x MUSB
In-Reply-To: <20150318011836.GK31346@atomide.com>
References: <1426637961-4197-1-git-send-email-tony@atomide.com>
 <1426637961-4197-4-git-send-email-tony@atomide.com>
 <20150318003121.GA12911@saruman.tx.rr.com>
 <20150318011836.GK31346@atomide.com>
Message-ID: <20150318144035.GB1116@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 17, 2015 at 06:18:37PM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [150317 17:32]:
> > Hi,
> > 
> > On Tue, Mar 17, 2015 at 05:19:20PM -0700, Tony Lindgren wrote:
> > > Looks like we have cppi41 on dm816x just like on am335x.
> > > 
> > > Cc: Bin Liu <binmlist@gmail.com>
> > > Cc: Brian Hutchinson <b.hutchman@gmail.com>
> > > Cc: Felipe Balbi <balbi@ti.com>
> > > Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > Any logs available ? Any throughput improvements with DMA ?
> 
> So far I only logged with the debug option on. I can do some
> test runs with your for-next branch to a USB mass storage device
> if you prefer that, or got some other test in mind?

mass storage should be fine, just wanna know if you're getting
acceptable throughput.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150318/869be06b/attachment.sig>
