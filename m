From: gleb@redhat.com (Gleb Natapov)
Date: Thu, 3 Oct 2013 07:04:34 +0300
Subject: [GIT PULL] KVM/ARM Fixes for 3.12-rc2
In-Reply-To: <CAOesGMgGTghYwaDB3uJTYBTOa73z+wcKfzfJGWWZyM-QjbijzQ@mail.gmail.com>
References: <1380052160-20755-1-git-send-email-christoffer.dall@linaro.org>
 <5242B1B0.1040408@redhat.com>
 <CAOesGMgGTghYwaDB3uJTYBTOa73z+wcKfzfJGWWZyM-QjbijzQ@mail.gmail.com>
Message-ID: <20131003040434.GA31244@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 02, 2013 at 01:14:57PM -0700, Olof Johansson wrote:
> Paolo,
> 
> On Wed, Sep 25, 2013 at 2:49 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > Il 24/09/2013 21:49, Christoffer Dall ha scritto:
> >> The following changes since commit 62d228b8c676232eca579f91cc0782b060a59097:
> >>
> >>   Merge branch 'fixes' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2013-09-17 22:20:30 -0400)
> >>
> >> are available in the git repository at:
> >>
> >>
> >>   git://git.linaro.org/people/cdall/linux-kvm-arm.git tags/kvm-arm-fixes-3.12-rc2
> >>
> >> for you to fetch changes up to ac570e0493815e0b41681c89cb50d66421429d27:
> >>
> >>   ARM: kvm: rename cpu_reset to avoid name clash (2013-09-24 11:15:05 -0700)
> >>
> >> ----------------------------------------------------------------
> >> KVM/ARM Fixes for 3.12-rc2
> >>
> >> Fixes compilation error with KVM/ARM enabled.
> >>
> >> ----------------------------------------------------------------
> >> Olof Johansson (1):
> >>       ARM: kvm: rename cpu_reset to avoid name clash
> >>
> >>  arch/arm/kvm/reset.c |    6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >
> > Pulled, thanks.
> 
> When do you expect to send your branch to Linus? I haven't seen it
> land there yet, nor in linux-next. This is keeping us from even
> building KVM-enabled kernels on ARM.
> 
It is in Linus tree for a couple of days now.

--
			Gleb.
