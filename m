From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 10 Jun 2015 17:11:36 -0700
Subject: [GIT PULL] Broadcom Device Tree changes for 4.2 (part 3)
In-Reply-To: <1433640869-12746-1-git-send-email-f.fainelli@gmail.com> (Florian
 Fainelli's message of "Sat, 6 Jun 2015 18:34:28 -0700")
References: <1433640869-12746-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <7hioavgl3b.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Florian Fainelli <f.fainelli@gmail.com> writes:

> The following changes since commit 9d7ef1b76c131f9b5e0a31fd1444d4fa6b8a841c:
>
>   ARM: dts: BCM63xx: re-parent NAND controller node (2015-05-27 09:57:34 -0700)
>
> are available in the git repository at:
>
>   https://github.com/Broadcom/stblinux tags/arm-soc/for-4.2/dts-part3
>
> for you to fetch changes up to 26343bdacfcdbf6ee3303d6078a015b908f90193:
>
>   ARM: BCM5301X: Add DT for Asus RT-AC87U (2015-06-06 16:13:16 -0700)
>
> ----------------------------------------------------------------
> This pull request contains Broadcom BCM5301x related changes:
>
> - Hauke adds the interrupt mapping for the BCM5301x PCIe controller
>
> - Haule adds support for NAND flash using the standard Broadcom NAND controller
>   iProc specific binding on BCM4708/5301x
>
> - Rafal adds support for the Asus RT-AC87U router
>
> ----------------------------------------------------------------

Pulled into next/dt,

Thanks,

Kevin
