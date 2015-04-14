From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 14 Apr 2015 12:23:45 +0200
Subject: [PATCH v2 08/10] KVM: arm64: guest debug, HW assisted debug
 support
In-Reply-To: <20150410122520.GA3227@hawk.usersys.redhat.com>
References: <1427814488-28467-1-git-send-email-alex.bennee@linaro.org>
 <1427814488-28467-9-git-send-email-alex.bennee@linaro.org>
 <20150410122520.GA3227@hawk.usersys.redhat.com>
Message-ID: <20150414102345.GV6186@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 10, 2015 at 02:25:21PM +0200, Andrew Jones wrote:

[...]

> > --- a/arch/arm64/kvm/sys_regs.c
> > +++ b/arch/arm64/kvm/sys_regs.c
> > @@ -196,16 +196,49 @@ static bool trap_dbgauthstatus_el1(struct kvm_vcpu *vcpu,
> >   * - If the dirty bit is set, save guest registers, restore host
> >   *   registers and clear the dirty bit. This ensure that the host can
> >   *   now use the debug registers.
> > + *
> > + * We also use this mechanism to set-up the debug registers for guest
> setup

since I'm in this mood:

setup: noun or adjective
set-up: noun derived from the phrasal verb, example "Run! It's a set-up."
set up: verb

-Christoffer
