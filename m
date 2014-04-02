From: balbi@ti.com (Felipe Balbi)
Date: Wed, 2 Apr 2014 11:21:54 -0500
Subject: OMAP baseline test results for v3.14
In-Reply-To: <20140402162102.GB12234@atomide.com>
References: <alpine.DEB.2.02.1404021600320.15928@utopia.booyaka.com>
 <20140402162102.GB12234@atomide.com>
Message-ID: <20140402162154.GJ8504@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 02, 2014 at 09:21:03AM -0700, Tony Lindgren wrote:
> * Paul Walmsley <paul@pwsan.com> [140402 09:07]:
> > 
> > Here are some basic OMAP test results for Linux v3.14.
> > Logs and other details at:
> > 
> >     http://www.pwsan.com/omap/testlogs/test_v3.14/20140402004448/
> > 
> > Boot to userspace:
> >     FAIL ( 1/12): 2430sdp
> 
> Is this a new regression with MMC? Looks like your boot log for this
> ends with "Waiting for root device /dev/mmcblk0p1...".

Nishanth already posted about this a few days ago, see [1]

[1] http://marc.info/?l=linux-omap&m=139637044425644&w=2

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140402/327b6b64/attachment.sig>
