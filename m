From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 30 Jul 2014 20:54:47 +0200
Subject: [GIT PULL] KVM/ARM Urgent fix for 3.16
In-Reply-To: <53D8F453.9010101@redhat.com>
References: <1406724941-4283-1-git-send-email-christoffer.dall@linaro.org>
 <53D8F453.9010101@redhat.com>
Message-ID: <20140730185447.GF11610@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 30, 2014 at 03:34:11PM +0200, Paolo Bonzini wrote:
> Il 30/07/2014 14:55, Christoffer Dall ha scritto:
> > Hi Paolo and Gleb,
> > 
> > Is there any chance you can get this urgent fix (which allows KVM guest
> > to bring down the entire system on some 64K enabled ARM64 hosts) merged
> > for 3.16?
> > 
> > The following changes since commit bb18b526a9d8d4a3fe56f234d5013b9f6036978d:
> > 
> >   Merge tag 'signed-for-3.16' of git://github.com/agraf/linux-2.6 into kvm-master (2014-07-08 12:08:58 +0200)
> > 
> > are available in the git repository at:
> > 
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvm-arm-for-3.16-rc7
> > 
> > for you to fetch changes up to 63afbe7a0ac184ef8485dac4914e87b211b5bfaa:
> > 
> >   kvm: arm64: vgic: fix hyp panic with 64k pages on juno platform (2014-07-30 14:35:42 +0200)
> > 
> > ---
> > Will Deacon (1):
> >   kvm: arm64: vgic: fix hyp panic with 64k pages on juno platform
> > 
> >  virt/kvm/arm/vgic.c | 24 ++++++++++++++++++++----
> >  1 file changed, 20 insertions(+), 4 deletions(-)
> > 
> 
> I think Gleb is on vacation now, but unfortunately I've already had
> enough this year.
> 
> I resent the pull request from
> git://git.kernel.org/pub/scm/virt/kvm/kvm.git, even though you had CCed
> Linus here already.
> 
I cc'ed Linus in case you were on vacation and since this is urgent and
last minute.

In any case, thanks to all for dealing with this quickly.

-Christoffer
