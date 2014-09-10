From: pbonzini@redhat.com (Paolo Bonzini)
Date: Wed, 10 Sep 2014 11:34:53 +0200
Subject: [PATCH 0/2] KVM API documentation patches
In-Reply-To: <1410280039-2823-1-git-send-email-alex.bennee@linaro.org>
References: <1410280039-2823-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <54101B3D.20000@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il 09/09/2014 18:27, Alex Benn?e ha scritto:
> Hi,
> 
> I'm preparing to add ARM KVM GDB support and I went to read the API
> documentation and found it surprisingly mute on the subject ;-)
> 
> The first patch documents the "new" KVM_SET_GUEST_DEBUG ioctl based on
> reviewing the code. I've included a long CC list of people who've
> actually done the various implementations who I hope can sanity check
> the write-up. The second is a trivial formatting fix for what looks
> like a minor merge trip-up.
> 
> Alex Benn?e (2):
>   KVM: document KVM_SET_GUEST_DEBUG api
>   KVM: fix api documentation of KVM_GET_EMULATED_CPUID
> 
>  Documentation/virtual/kvm/api.txt | 184 +++++++++++++++++++++++---------------
>  1 file changed, 114 insertions(+), 70 deletions(-)
> 

Thanks, applying both!

Paolo
