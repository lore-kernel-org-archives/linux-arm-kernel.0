From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 27 Jan 2016 19:19:50 +0100
Subject: [PATCH] ARM: dts: omap3: Include missing bandgap data for
 ti-soc-thermal driver
In-Reply-To: <20160127160945.GI19432@atomide.com>
References: <1451086345-3340-1-git-send-email-pali.rohar@gmail.com>
 <20160121094718.GV7192@pali> <20160121171500.GI19432@atomide.com>
 <20160127100447.GI25796@pali> <20160127160945.GI19432@atomide.com>
Message-ID: <20160127181950.GB17794@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 27, 2016 at 08:09:46AM -0800, Tony Lindgren wrote:
> * Pali Roh?r <pali.rohar@gmail.com> [160127 02:05]:
> > On Thursday 21 January 2016 09:15:01 Tony Lindgren wrote:
> > > * Pali Roh?r <pali.rohar@gmail.com> [160121 01:48]:
> > > > On Saturday 26 December 2015 00:32:25 Pali Roh?r wrote:
> > > > > Driver for omap3 with documentation is there since v4.4-rc1.
> > > ...
> > > 
> > > > PING! Who can take this patch?
> > > 
> > > Sounds like /me, but after -rc1 when any possible regressions
> > > are out of the way :)
> > 
> > Great! Just to note that 4.5-rc1 is out.
> > 
> > I just do not want to see this patch lost...
> 
> So is this critical to have as a fix since it's thermal related?

According to somebody from TI, who previously took part in the patch
discussion, the thermal sensors of omap3 are to imprecise to be used
for thermal decisions. The driver "just" informs userspace about the
temperatures.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160127/9920a723/attachment.sig>
