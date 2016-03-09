From: tn@semihalf.com (Tomasz Nowicki)
Date: Wed, 9 Mar 2016 12:35:26 +0100
Subject: [PATCH v3 00/16] KVM: arm64: GICv3 ITS emulation
In-Reply-To: <1444229726-31559-1-git-send-email-andre.przywara@arm.com>
References: <1444229726-31559-1-git-send-email-andre.przywara@arm.com>
Message-ID: <56E00A7E.4080101@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

Forgive me if anybody already asked this question for previous series 
versions.

The review is still pending so it is worth to ask. What is your idea for 
saving and restoring vITS state? I notice device, itte and collection 
linked lists which are essential for vITS state. Of course it is not 
feasible to transfer these list to e.g. QEMU using 
KVM_{GET|SET}_DEVICE_ATTR.

Regards,
Tomasz
