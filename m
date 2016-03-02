From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 2 Mar 2016 08:07:47 +0000
Subject: [PATCH 00/19] arm64 kexec kernel patches v13
In-Reply-To: <1456881475.6738.18.camel@infradead.org>
References: <cover.1452884156.git.geoff@infradead.org>
 <c7575f853ccc491bb0212e025aab1cc9@NASANEXM01H.na.qualcomm.com>
 <56D5D763.4030304@codeaurora.org>
 <1456881475.6738.18.camel@infradead.org>
Message-ID: <20160302080747.05f0c01a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 1 Mar 2016 17:17:55 -0800
Geoff Levand <geoff@infradead.org> wrote:

Geoff,

> Hi,
> 
> On Tue, 2016-03-01 at 10:54 -0700, Azriel Samson wrote:
> 
> > We have been using the kexec/kdump patches on ARM64 and would like to
> > use them from upstream.
> > 
> > Assuming these are not going to be in Linux-4.5, a rebased set on 
> > Linux-4.5 would be very useful.
> 
> I'm waiting for one of two things to happen, either Marc Zyngier gives
> an ack for the patch 'arm64: kvm: allows kvm cpu hotplug', or the arm64
> maintainers decide they will accept my proposal to merge kexec with a
> conditional in the Kconfig that only allows one of KVM or kexec to be
> selected.

Do you expect me to give my Ack on a series that I cannot even apply
(let alone test) with mainline?

> The kexec patches have been in review for 20 months now, with only
> minor changes in the past 15.

Given the amount of comment each posting of this series has attracted, I
think we have a different appreciation of what a minor change is.

> I don't expect much would be gained in posting the kexec series again
> unless there is a chance they would be merged.

I think that's perfectly fine. Akashi Takahiro and James Morse have
been working together for a while now, reusing part of the kexec series
for the hibernate support (and not breaking KVM, oddly enough). My vote
is that they both take over the maintenance of this series on top the
the hibernate support, and finish the job.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
