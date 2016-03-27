From: itaru.kitayama@riken.jp (Itaru Kitayama)
Date: Sun, 27 Mar 2016 11:21:08 +0900
Subject: [PATCH v4 0/9] arm64: Add support for KVM with ACPI
Message-ID: <56F74394.5020106@riken.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julien,

Which git tree are you basing upon for these patch series?

I have applied your patch set to Catalin's tree, even though GICv3 part
wasn't cleanly applied, the kernel boots fine initializing KVM properly on
Mustang which has fairly recent beta F/W from APM.
