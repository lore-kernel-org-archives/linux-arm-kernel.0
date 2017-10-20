From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Oct 2017 22:27:37 +0200
Subject: [GIT PULL 2/2] Broadcom drivers changes for 4.15 (part 1)
In-Reply-To: <20170925190112.3915-2-f.fainelli@gmail.com>
References: <20170925190112.3915-1-f.fainelli@gmail.com>
 <20170925190112.3915-2-f.fainelli@gmail.com>
Message-ID: <CAK8P3a0FYQu5GESHFTunJQC7kVfvBoocJRG2+Fr1SoQyRkoZDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 25, 2017 at 9:01 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> This pull requests contains Broadcom SoCs drivers updates for 4.15, please pull
> the following:
>
> - Markus adds support for the Broadcom STB DDR PHY frontend which supports
>   dynamic firmware loading and offers the ability to respond with DRAM refresh
>   rates. He also adds a proper documentation binding document for that
>   peripheral
>
> - Brian adds support for S2/S3/S5 system suspend/resume modes on ARM-based SoCs
>   which is not new but had been lingering for a long time.
>
> - Justin adds S2/S3 system suspend/resume modes on MIPS-based SoCs which is a
>   bit new newer and builds on top of the ARM-based support.
>
> - Florian adds Device Tree binding documents for both ARM and MIPS based systems
>   describing the necessary nodes for S2/S3/S5 on these SoCs.
>
> (This pull request somehow missed the 4.14 merge window and is now being sent again
> for 4.15 along with build fixes from Arnd).

Pulled into next/drivers, thanks!

        Arnd
