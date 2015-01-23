From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 23 Jan 2015 13:55:53 +0100
Subject: [GIT PULL 03/36] arm/arm64: KVM: add tracing support for arm64
 exit handler
In-Reply-To: <54C24365.1000503@redhat.com>
References: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
 <1422007385-14730-4-git-send-email-christoffer.dall@linaro.org>
 <20150123113515.GF23493@leverpostej> <54C2382E.6040800@redhat.com>
 <54C24365.1000503@redhat.com>
Message-ID: <20150123125553.GM15076@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 23, 2015 at 01:49:41PM +0100, Paolo Bonzini wrote:
> 
> 
> On 23/01/2015 13:01, Paolo Bonzini wrote:
> > 
> > 
> > On 23/01/2015 12:35, Mark Rutland wrote:
> >>
> >> https://lkml.org/lkml/2015/1/22/7
> >> https://lkml.org/lkml/2015/1/22/8
> >>
> >> I'd hoped we'd be able to fix that before this went further upstream.
> >>
> >> The easiest way I could see to do that was to merge my esr branch (which
> >> is stable and Catalin has pulled) branch into the kvm-arm tree, and fix
> >> the conflicts there.
> >>
> >> Is there any chance we can fix that now?
> > 
> > I'll fix the conflicts in the kvm tree.  Please wait for further
> > instructions...
> 
> Ok folks, please check that the resolution in the queue branch of
> git://git.kernel.org/pub/scm/virt/kvm/kvm.git is okay.
> 
Looks great, I gave a quick spin on Juno and no problems, thanks Paolo!

-Christoffer
