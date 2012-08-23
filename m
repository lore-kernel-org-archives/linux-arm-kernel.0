From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 23 Aug 2012 11:04:52 +0800
Subject: [PATCH 3/3] pinctrl: sirf: add DT-binding pinmux mapping support
In-Reply-To: <1345690074-31327-4-git-send-email-Barry.Song@csr.com>
References: <1345690074-31327-1-git-send-email-Barry.Song@csr.com>
 <1345690074-31327-4-git-send-email-Barry.Song@csr.com>
Message-ID: <CAGsJ_4ziz=11DQGnnO5pEutrZzq4h3d-WU7UkGEVs2bzgmjq_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Barry Song <Baohua.Song@csr.com>
>
> This makes us possible to define pinmux mapping in board-specific DTS.
> prima2.dtsi provides all possible (groups,functions) configuration, and
> device in .dts select configurations from dtsi files.
>
> Signed-off-by: Barry Song <Barry.Song@csr.com>
> ---
>  arch/arm/boot/dts/prima2-evb.dts   |   37 ++++++
>  arch/arm/boot/dts/prima2.dtsi      |  221 +++++++++++++++++++++++++++++++++++-
>  arch/arm/mach-prima2/Makefile.boot |    2 +
>  drivers/pinctrl/pinctrl-sirf.c     |   58 +++++++++-
>  4 files changed, 315 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/boot/dts/prima2-evb.dts

Sorry for missing dt binding document, pls ignore this and take

[PATCH RESEND 3/3] pinctrl: sirf: add DT-binding pinmux mapping support

-barry
