From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 01 Jul 2015 13:40:16 -0700
Subject: [PATCH 0/2] ARM: BCM: Do not select MTD_NAND_BRCMNAND
In-Reply-To: <1435422344-31059-1-git-send-email-f.fainelli@gmail.com> (Florian
 Fainelli's message of "Sat, 27 Jun 2015 09:25:42 -0700")
References: <1435422344-31059-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <7h4mlnmx1r.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Florian Fainelli <f.fainelli@gmail.com> writes:

> Hi Arnd, Kevin, Olof,
>
> This two patches fix a linking failure when ARCH_BCM_IPROC is selected
> for the BRCMNAND driver since we end-up selecting this driver without
> its proper depdendencies. Instead do not do this select driver which is
> user-selectable, but add it to the multi_v7_defconfig.
>
> Let me know if you would prefer a pull request for this rather than
> individual patches. Thanks!

Individual patches are fine.

I've picked these up for the arm-soc/late branch which I'll try to get
in before -rc1, but if not it will make it for -rc2.

Thanks,

Kevin
