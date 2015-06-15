From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 15 Jun 2015 17:15:53 +0200
Subject: [PATCH] ARM: mm: enable L1 prefetch on Cortex-A9
In-Reply-To: <20150615150522.GN7557@n2100.arm.linux.org.uk>
References: <1434023550-20147-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20150615111103.GL7557@n2100.arm.linux.org.uk>
 <20150615165753.61d8c75a@free-electrons.com>
 <20150615150522.GN7557@n2100.arm.linux.org.uk>
Message-ID: <20150615171553.53b5c396@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, 15 Jun 2015 16:05:22 +0100, Russell King - ARM Linux wrote:

> > However, can you consider my "ARM: smp_scu: enable coherent speculative
> > linefills", which has been sent almost three months ago:
> > 
> >   http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/332106.html
> 
> I looked at that, and decided I didn't have enough information to know
> whether that's a good idea to apply or not for all the different variants
> we have out there.  It's something that needs to be merged early in the
> cycle to give it enough time to be (hopefully) tested by people.
> 
> A lot of these "enable optimisation X" patches need to go through that
> treatment.

Makes perfect sense. Can we get these "enable optimization X" patches
merged early enough in the 4.3 cycle, i.e right after 4.2-rc1 is
released?

Thanks a lot,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
