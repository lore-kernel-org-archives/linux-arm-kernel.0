From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 19 Jun 2013 14:05:16 +0200
Subject: [GIT PULL] Integrator/AP PCI DT support
In-Reply-To: <CACRpkdZaTDEu8vUx347k1Y5Pht5Pi_mPJXpDsVtAsSYVT60n_Q@mail.gmail.com>
References: <CACRpkdb8J4+QH36SYavgGWbFWaBZDg5JSYyyJELzL=mSZfMnBw@mail.gmail.com>
 <20130614230838.GA18124@quad.lixom.net>
 <20130615000922.GG18124@quad.lixom.net>
 <CACRpkdZaTDEu8vUx347k1Y5Pht5Pi_mPJXpDsVtAsSYVT60n_Q@mail.gmail.com>
Message-ID: <CACRpkdYsmMLGF_u26Zxx3modFsFybk0KZe92c9D1rT2bd_XW=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 15, 2013 at 10:32 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:

> OK here is the fixed branch, using the v3 patch of DT enablement just
> posted to the list, please pull this instead (still the same base):
>
>
> The following changes since commit 4e23d3f505e8acfeac7cc33d4113fbb5a25c3090:
>
>   of/pci: Add of_pci_parse_bus_range() function (2013-05-19 20:30:10 +0000)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
> tags/integrator-pci-for-arm-soc
>
> for you to fetch changes up to f55b2b56cd37fa8bcfcb75248c27094eaf09e04c:
>
>   ARM: integrator: basic PCIv3 device tree support (2013-06-15 22:18:39 +0200)
>
> ----------------------------------------------------------------
> This is a patch series that:
> - Pulls the Integrator/AP PCI bridge driver into one file
> - Adds full device tree support for it
> - Keeps ATAG support around for the time being
>
> ----------------------------------------------------------------

Ping on this...

Yours,
Linus Walleij
