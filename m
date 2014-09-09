From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Tue,  9 Sep 2014 17:27:17 +0100
Subject: [PATCH 0/2] KVM API documentation patches
Message-ID: <1410280039-2823-1-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm preparing to add ARM KVM GDB support and I went to read the API
documentation and found it surprisingly mute on the subject ;-)

The first patch documents the "new" KVM_SET_GUEST_DEBUG ioctl based on
reviewing the code. I've included a long CC list of people who've
actually done the various implementations who I hope can sanity check
the write-up. The second is a trivial formatting fix for what looks
like a minor merge trip-up.

Alex Benn?e (2):
  KVM: document KVM_SET_GUEST_DEBUG api
  KVM: fix api documentation of KVM_GET_EMULATED_CPUID

 Documentation/virtual/kvm/api.txt | 184 +++++++++++++++++++++++---------------
 1 file changed, 114 insertions(+), 70 deletions(-)

-- 
2.1.0
