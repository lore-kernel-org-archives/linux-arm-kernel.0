From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 12 Feb 2013 19:49:42 +0100
Subject: ARM big-endian on current kernels for linux-3.8
In-Reply-To: <511A7B14.1020107@codethink.co.uk>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
 <20130212180858.289c3efa@skate> <511A7B14.1020107@codethink.co.uk>
Message-ID: <20130212194942.1ec29bf4@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ben Dooks,

On Tue, 12 Feb 2013 17:25:40 +0000, Ben Dooks wrote:

> >> Feedback and testing is welcome.
> >
> > I've tested your patch set on Armada XP. The kernel boots fine, but
> > it fails to bring up the secondary CPUs:
> 
> Yes, missed updating the coherency_ll.S patch.
> 
> Attached new patch

Thanks, I'll test this one tomorrow. Any pointer for a known-working
armeb toolchain?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
