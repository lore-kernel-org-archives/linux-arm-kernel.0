From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 26 Jan 2012 21:43:12 -0500 (EST)
Subject: [PATCH v3] ARM: support XZ compressed kernels
In-Reply-To: <op.v8pljuvl2s3iss@ecaz>
References: <1320696216-5570-1-git-send-email-kaloz@openwrt.org>
 <CACRpkdb1RhmB4d2DfWp4B3OVybt-NMnku-fo+bHDuPWdi9LddQ@mail.gmail.com>
 <op.v4vsotxk2s3iss@ecaz> <4F180128.9060005@bluegiga.com>
 <op.v8bxi2yu2s3iss@ecaz> <4F20353E.70809@bluegiga.com>
 <20120126202630.GB11941@n2100.arm.linux.org.uk> <op.v8pljuvl2s3iss@ecaz>
Message-ID: <alpine.LFD.2.02.1201262139410.2759@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Jan 2012, Imre Kaloz wrote:

> Hi Russell,
> 
> On Thu, 26 Jan 2012 21:26:30 +0100, Russell King - ARM Linux
> > So yes, as the problem has been resolved, we can now move forward on
> > it.  I'm not sure it's -rc material though, so I'll queue it for the
> > next merge window.  We've waited six months already since the 'fix'
> > went in, so plainly another three won't hurt one bit.
> 
> When I've noticed v2 didn't get upstream without that change, I did a v3, and
> got no response for that from you [1]. Than the string.c related changes broke
> that, hence this (v4) version. If possible, please try to get this into 3.3,
> as I think there's no chance it could break anything.

That doesn't matter if this may or may not break anything.  The merge 
window for v3.3 is over, and only bug fixes are acceptable now 
until the next merge window opens.


Nicolas
