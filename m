From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 12 Jan 2015 18:19:23 +0100
Subject: [GIT PULL 0/2] KVM/ARM Fixes for 3.19
In-Reply-To: <54B39EA4.50808@redhat.com>
References: <1420981811-18731-1-git-send-email-christoffer.dall@linaro.org>
 <54B39EA4.50808@redhat.com>
Message-ID: <20150112171923.GA24754@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 12, 2015 at 11:15:00AM +0100, Paolo Bonzini wrote:
> 
> 
> On 11/01/2015 14:10, Christoffer Dall wrote:
> > Hi Paolo,
> > 
> > The following changes since commit b1940cd21c0f4abdce101253e860feff547291b0:
> > 
> >   Linux 3.19-rc3 (2015-01-05 17:05:20 -0800)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvm-arm-fixes-3.19
> > 
> > for you to fetch changes up to b5b8ddba844c6b6c5b96c27b284d9ed05a16fa13:
> > 
> >   arm64: KVM: Fix HCR setting for 32bit guests (2015-01-11 13:54:51 +0100)
> > 
> > (Note that I got an extra merge commit when merging kvm/master into
> > kvmarm/master, which I think is because Linus applied the set of fixes
> > from kvmarm/master directly from Marc's patches. Let me know if you need
> > me to mangle this differently somehow.)
> 
> Hmm, that's a bit ugly.  I'll apply the patches directly too, please do
> a "git reset --hard kvm/master" before applying more stuff.
> 
ok, we did try to (and say publicly) that we'd keep kvmarm/master a
stable branch (like it also says about kvm/master on the KVM wiki), so
that's why I did this.

I guess we can just require people that follow kvmarm/master (if any) to
deal with things accordingly.

-Christoffer
