From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 11 Sep 2014 15:58:02 -0700
Subject: [PATCH 0/2] KVM API documentation patches
In-Reply-To: <54101B3D.20000@redhat.com>
References: <1410280039-2823-1-git-send-email-alex.bennee@linaro.org>
 <54101B3D.20000@redhat.com>
Message-ID: <20140911225802.GU5535@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 11:34:53AM +0200, Paolo Bonzini wrote:
> Il 09/09/2014 18:27, Alex Benn?e ha scritto:
> > Hi,
> > 
> > I'm preparing to add ARM KVM GDB support and I went to read the API
> > documentation and found it surprisingly mute on the subject ;-)
> > 
> > The first patch documents the "new" KVM_SET_GUEST_DEBUG ioctl based on
> > reviewing the code. I've included a long CC list of people who've
> > actually done the various implementations who I hope can sanity check
> > the write-up. The second is a trivial formatting fix for what looks
> > like a minor merge trip-up.
> > 
> > Alex Benn?e (2):
> >   KVM: document KVM_SET_GUEST_DEBUG api
> >   KVM: fix api documentation of KVM_GET_EMULATED_CPUID
> > 
> >  Documentation/virtual/kvm/api.txt | 184 +++++++++++++++++++++++---------------
> >  1 file changed, 114 insertions(+), 70 deletions(-)
> > 
> 
> Thanks, applying both!
> 
ha, read this after reviewing his text.  Was I too nit-picky? ;)

-Christoffer
