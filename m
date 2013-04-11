From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 Apr 2013 18:57:12 +0200
Subject: [PATCH v5 1/3] of/pci: Unify pci_process_bridge_OF_ranges from
 Microblaze and PowerPC
In-Reply-To: <20130410233059.5cdcc119@skate>
References: <1365578969-30966-1-git-send-email-Andrew.Murray@arm.com>
 <1365578969-30966-2-git-send-email-Andrew.Murray@arm.com>
 <51656592.7070806@gmail.com> <20130410233059.5cdcc119@skate>
Message-ID: <CACRpkdY1PNLp7guzazCUvLCs8OqTopm40wg6L0DAC+2+Eu91og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 11:30 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> Ben, Michal, could you review/test this patch from Andrew Murray? I
> need it as a dependency of "[PATCH v5 2/3] of/pci: Provide support for
> parsing PCI DT ranges property", which itself is used by the Marvell
> PCIe driver I'm hoping to get merged in 3.10.

Second this, I also have a patch series that depend on these patches.

Yours,
Linus Walleij
