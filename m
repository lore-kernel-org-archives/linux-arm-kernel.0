From: olof@lixom.net (Olof Johansson)
Date: Wed, 25 Sep 2013 22:02:42 -0700
Subject: [PATCH] arm: mach-integrator: Add stub for pci_v3_early_init()
 for !CONFIG_PCI
In-Reply-To: <CACRpkdZ5G02w9JivgfVW4LvGe35=uCD+ROLC0+iL4HzFaAh9ng@mail.gmail.com>
References: <1380103893-7119-1-git-send-email-joro@8bytes.org>
 <CACRpkdZ5G02w9JivgfVW4LvGe35=uCD+ROLC0+iL4HzFaAh9ng@mail.gmail.com>
Message-ID: <CAOesGMjFi8BdcYT7rswcAyvYVqJxBZeFNOEO8EJhj9uEp-wKGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 25, 2013 at 6:39 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Sep 25, 2013 at 12:11 PM, Joerg Roedel <joro@8bytes.org> wrote:
>
>> This fixes a compile error where CONFIG_PCI is disabled:
>
> ARM SoC folks, can you please apply this directly for fixes?

Done!

Thanks,

-Olof
