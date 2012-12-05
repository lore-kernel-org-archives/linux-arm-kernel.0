From: will.deacon@arm.com (Will Deacon)
Date: Wed, 5 Dec 2012 15:10:29 +0000
Subject: [RFC PATCH 0/2] Add support for a fake, para-virtualised machine
In-Reply-To: <alpine.LFD.2.02.1212051001140.6589@xanadu.home>
References: <1354557160-20144-1-git-send-email-will.deacon@arm.com>
 <50BD1F81.9080304@gmail.com>
 <20121204123001.GL23368@mudshark.cambridge.arm.com>
 <50BE04C6.4070602@gmail.com>
 <alpine.LFD.2.02.1212041142490.6589@xanadu.home>
 <20121204171129.GE5314@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1212041252290.6589@xanadu.home>
 <20121204181446.GJ5314@mudshark.cambridge.arm.com>
 <CAHkRjk5HgM=kL5Li_9qrwXfD+vJGvLLoha_ns6KFdxZW7gLwbA@mail.gmail.com>
 <alpine.LFD.2.02.1212051001140.6589@xanadu.home>
Message-ID: <20121205151029.GK22385@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 05, 2012 at 03:07:05PM +0000, Nicolas Pitre wrote:
> On Wed, 5 Dec 2012, Catalin Marinas wrote:
> > On 4 December 2012 18:14, Will Deacon <will.deacon@arm.com> wrote:
> > > Well, this depends on the guest taking an undefined instruction exception on
> > > the smc, then deciding to issue an hvc instead and *then* having the
> > > hypervisor somehow translate that into a PSCI invocation. It could work, but
> > > it sounds easy to mess up and relies on the PSCI firmware co-existing with
> > > things like kvm.
> > 
> > We can have enable-method DT entries independent of the SoC and one of
> > them can be psci-hvc.
> > 
> > Just for clarification, AArch32 with virtualisation mandates the
> > security extensions, so the SMC can be trapped.
> 
> Good. Therefore this one is settled.

Looks we replied at the same time! Please see my other mail...

Will
