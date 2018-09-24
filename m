From: ykaukab@suse.de (Mian Yousaf Kaukab)
Date: Mon, 24 Sep 2018 12:06:20 +0200
Subject: [PATCH RESEND 0/6] arm64: add support for generic cpu
 vulnerabilities
In-Reply-To: <20180917133508.GE23040@arm.com>
References: <20180827143310.641-1-ykaukab@suse.de>
 <20180905092533.GB17376@suse.de> <20180917133508.GE23040@arm.com>
Message-ID: <20180924100620.GA19083@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2018 at 02:35:08PM +0100, Will Deacon wrote:
> On Wed, Sep 05, 2018 at 11:25:33AM +0200, Mian Yousaf Kaukab wrote:
> > On Mon, Aug 27, 2018 at 04:33:04PM +0200, Mian Yousaf Kaukab wrote:
> > > GENERIC_CPU_VULNERABILITIES provide a common way to figure out if a
> > > system is affected by vulnerabilities like meltdown and other variants
> > > of spectre. This small series adds support for it in arm64.
> > 
> > Marc, Will, Can you please review this series?
> 
> Sorry it took so long to get to this, it's just consistently failed to
> get to the top of my review queue. I had a quick look just now and there
> are a few things to address before we can take the series.
Thank you for the review. I will get back to you after fixing the comments as soon as possible.

> 
> Cheers,
> 
> Will

Thanks,
Yousaf
