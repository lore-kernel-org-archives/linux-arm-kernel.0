From: subashrp@gmail.com (Subash Patel)
Date: Tue, 12 Apr 2011 12:16:10 +0530
Subject: A15 h/w virtulization support
Message-ID: <BANLkTi=cOmWQuPY_aG5T6JoOAYCXshdyPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

If I am not wrong, Cortex-A15 is WIP with many SoC vendors. From my
understanding, A15 has additional operational mode "hypervisor mode"
and SMMU support for GuestOS memory to IPA in VMM, and IPA in VMM into
PA. I was curious to know whether ARM v7 changes for Linux
is happening for this? This will help to understand the KVM changes
that may be required to run Linux directly in ring-0, and support
guest OS?

Regards,
Subash
