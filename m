From: will.deacon@arm.com (Will Deacon)
Date: Mon, 12 Aug 2013 18:24:47 +0100
Subject: [GIT PULL] CCI PMU driver for 3.12
Message-ID: <20130812172447.GG25995@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Kevin,

Please can you pull the following perf update for 3.12? I was hoping to have
some unwinding improvements too, but I've not had a chance to complete that
work, so it's just the single patch from Punit to add support for the PMU
driver on the CCI.

Apologies for sending this post -rc5, but I've been travelling for the past
week and had some issues testing the driver myself. If you're snowed under,
feel free to queue this for 3.13 instead.

Cheers,

Will

--->8

The following changes since commit c095ba7224d8edc71dcef0d655911399a8bd4a3f:

  Linux 3.11-rc4 (2013-08-04 13:46:46 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-perf-3.12

for you to fetch changes up to 8747763c249fb36bd5c882f4e9d63e7b4c674204:

  drivers: CCI: add ARM CCI PMU support (2013-08-12 14:02:34 +0100)

----------------------------------------------------------------
Addition of an ARM PMU driver for the CCI-400 coherent interconnect
found on big.LITTLE systems, such as TC2.

----------------------------------------------------------------
Punit Agrawal (1):
      drivers: CCI: add ARM CCI PMU support

 Documentation/devicetree/bindings/arm/cci.txt |  38 +++++++++++
 drivers/bus/arm-cci.c                         | 642 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 680 insertions(+)
