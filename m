From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 5 Dec 2014 23:09:02 +0530
Subject: [PATCH v5 34/61] dmaengine: omap: Split device_control
In-Reply-To: <20141205170744.GW30256@lukather>
References: <1416231775-31252-1-git-send-email-maxime.ripard@free-electrons.com>
 <1416231775-31252-35-git-send-email-maxime.ripard@free-electrons.com>
 <20141205142702.GF3411@intel.com> <20141205143359.GV30256@lukather>
 <20141205145642.GI3411@intel.com> <20141205170744.GW30256@lukather>
Message-ID: <20141205173902.GT3411@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 05, 2014 at 06:07:44PM +0100, Maxime Ripard wrote:
> On Fri, Dec 05, 2014 at 08:26:42PM +0530, Vinod Koul wrote:
> > On Fri, Dec 05, 2014 at 03:33:59PM +0100, Maxime Ripard wrote:
> Ah, right.
> 
> I have no idea why it haven't been picked up by intel's build bot
> thuough.
possibly no defconfig enables this

> 
> Anyway. Do you want me to send a new version of these patches for this
> trivial fix and the mxs one, or do you want me to send a follow-up?
I am halfway thru series, if I dont find anything serious I will fix it up and
push over the weekend

-- 
~Vinod
> 
> Maxime
> 
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com



-- 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141205/cbe819e7/attachment.sig>
