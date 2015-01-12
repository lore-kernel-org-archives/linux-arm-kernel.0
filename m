From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 12 Jan 2015 19:47:38 +0100
Subject: [GIT PULL 0/2] KVM/ARM Fixes for 3.19
In-Reply-To: <54B4141E.5070602@redhat.com>
References: <1420981811-18731-1-git-send-email-christoffer.dall@linaro.org>
 <54B39EA4.50808@redhat.com> <20150112171923.GA24754@cbox>
 <54B4141E.5070602@redhat.com>
Message-ID: <20150112184738.GN3868@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 12, 2015 at 07:36:14PM +0100, Paolo Bonzini wrote:
> 
> 
> On 12/01/2015 18:19, Christoffer Dall wrote:
> >> > Hmm, that's a bit ugly.  I'll apply the patches directly too, please do
> >> > a "git reset --hard kvm/master" before applying more stuff.
> >> > 
> > ok, we did try to (and say publicly) that we'd keep kvmarm/master a
> > stable branch (like it also says about kvm/master on the KVM wiki), so
> > that's why I did this.
> > 
> > I guess we can just require people that follow kvmarm/master (if any) to
> > deal with things accordingly.
> 
> Yeah, I agree that this shouldn't have happened.
> 
> It's not the end of the world.  People that pull from kvmarm/master will
> almost always rebase their trees, and the rebase will discard the
> duplicate patches.
> 
> The big problem with rebasing happens if you _drop_ patches.  In that
> case, whoever rebases will keep the patch that you dropped, and most
> likely will not notice.
> 
That's a good point.  And I don't think anyone directly integrates the
kvmarm/master branch into anything anyway.

I will reset the branch.


Thanks,
-Christoffer
