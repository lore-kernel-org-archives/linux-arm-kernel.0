From: robherring2@gmail.com (Rob Herring)
Date: Mon, 5 May 2014 09:42:43 -0500
Subject: [PATCH 1/3] ARM: mvebu: clean-up unneeded kconfig selects
In-Reply-To: <20140505045529.GA16022@quad.lixom.net>
References: <1398195678-28787-1-git-send-email-robherring2@gmail.com>
 <1398195678-28787-2-git-send-email-robherring2@gmail.com>
 <20140505045529.GA16022@quad.lixom.net>
Message-ID: <CAL_JsqLNUoa3_1SFMicgCvEPzczsdadasgJZHRRPau+n-gQ0sA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 4, 2014 at 11:55 PM, Olof Johansson <olof@lixom.net> wrote:
> On Tue, Apr 22, 2014 at 02:41:16PM -0500, Rob Herring wrote:
>> From: Rob Herring <robh@kernel.org>
>>
>> Multi-platform support implies all these options are already selected and
>> individual platforms don't need to select them.
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> Cc: Jason Cooper <jason@lakedaemon.net>
>> Cc: Andrew Lunn <andrew@lunn.ch>
>> Cc: Gregory Clement <gregory.clement@free-electrons.com>
>> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>
> What's this based on? It doesn't apply to 3.15-rc4.

v3.15-rc2. That's strange because there are no other changes since
rc2. Here's a pull request instead.

Rob

The following changes since commit a798c10faf62a505d24e5f6213fbaf904a39623f:

  Linux 3.15-rc2 (2014-04-20 11:08:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
tags/kconfig-cleanups

for you to fetch changes up to e7062b101537a0c4f4a8d725321772eb78100074:

  ARM: qcom: clean-up unneeded kconfig selects (2014-04-22 14:33:27 -0500)

----------------------------------------------------------------
Several mach kconfig clean-ups of redundant selects

----------------------------------------------------------------
Rob Herring (3):
      ARM: mvebu: clean-up unneeded kconfig selects
      ARM: bcm: clean-up unneeded kconfig selects
      ARM: qcom: clean-up unneeded kconfig selects

 arch/arm/mach-bcm/Kconfig   | 8 --------
 arch/arm/mach-mvebu/Kconfig | 6 ------
 arch/arm/mach-qcom/Kconfig  | 2 --
 3 files changed, 16 deletions(-)
