From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Oct 2017 13:13:14 +0100
Subject: [GIT PULL 2/5] Broadcom devicetree changes for 4.15
In-Reply-To: <20171021001636.17662-2-f.fainelli@gmail.com>
References: <20171021001636.17662-1-f.fainelli@gmail.com>
 <20171021001636.17662-2-f.fainelli@gmail.com>
Message-ID: <CAK8P3a33AdmCWgo+A170bZemnBkBd01M2=aJosZ9P+Gy2GtVCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 21, 2017 at 2:16 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> This pull request contains Broadcom ARM-based Device Tree changes for 4.15,
> please pull the following:
>
> - Eric adds support for the CLCD and PWM controller on Cygnus chis
>
> - Loic fixes the console path on the Raspberry Pi 3 (already submitted as
>   fixes) and then proceeds with enabling the BCM43438 bluetooth chip on
>   the Raspberry Pi 3
>
> - Rafal specifies the USB ports on the Luxul XWR-1200
>
> - Dan adds support for the Luxul ABR-4500 based on BCM47094, the Luxul XAP-810
>   and XAP-1440 both based on BCM53573
>
> - Florian adds support for the Broadcom Hurricane 2 SoC by adding general
>   machine binding, clock binding, SoC DTS include file and a DTS for the
>   Ubiquiti Networks UniFi Switch 8

Pulled into next/dt, thanks!

      Arnd
