From: hjk@hansjkoch.de (Hans J. Koch)
Date: Fri, 4 Mar 2011 17:05:22 +0100
Subject: [PATCH v10 1/1] PRUSS UIO driver support
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024C009039@dbde02.ent.ti.com>
References: <1299213772-21931-1-git-send-email-pratheesh@ti.com>
	<1299213772-21931-2-git-send-email-pratheesh@ti.com>
	<20110304142028.GD28175@local>
	<B85A65D85D7EB246BE421B3FB0FBB593024C009039@dbde02.ent.ti.com>
Message-ID: <20110304160522.GE28175@local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 04, 2011 at 08:11:56PM +0530, Nori, Sekhar wrote:
> Hi Hans,
> 
> On Fri, Mar 04, 2011 at 19:50:28, Hans J. Koch wrote:
> > On Fri, Mar 04, 2011 at 10:12:52AM +0530, Pratheesh Gangadhar wrote:
> > > diff --git a/include/linux/uio_pruss.h b/include/linux/uio_pruss.h
> > > new file mode 100644
> > > index 0000000..8c9b2c9
> > > --- /dev/null
> > > +++ b/include/linux/uio_pruss.h
> > 
> > That should go to arch/arm/mach-davinci/include/mach/
> > and not to the top level include/linux/ directory.
> 
> It was put in here because this driver
> will be used across two ARM architectures
> (DaVinci and OMAP). Although it won't be used
> outside of ARM at least in near future.

OK, I accept that. I'll review the rest soon.

Thanks,
Hans
