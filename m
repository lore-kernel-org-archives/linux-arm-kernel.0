From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Mar 2018 22:38:57 +0100
Subject: [GIT PULL 1/2] Broadcom devicetree changes for 4.17
In-Reply-To: <20180313195259.20496-1-f.fainelli@gmail.com>
References: <20180313195259.20496-1-f.fainelli@gmail.com>
Message-ID: <CAK8P3a224VHwAW3j1WAAxe7G50ctaiHSfaqj2mU_aheWMoA_NQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2018 at 8:52 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM-based SoCs devicetree changes
> for 4.17, please pull the following:
>
> - Henry fixes the pin functions for the JTAG pins, nothing uses this for
>   now, but it could be backported eventually if deemed appropriate
>
> - Stefan fixes the register ranges for the bcm2835-i2s nodes in the
>   binding document definition, he then fixes the probing of the
>   bcm2835-i2s driver by providing an appropriate register range and a
>   missing clock. Stefan also makes sure that the appropriate pull
>   settings are applied to the pins used on the Raspberry Pi Zero
>   Wireless, he then adds the necessary UART node to connected to the
>   BCM43438 Bluetooth adapter on the Pi Zero W. He finally enables USB
>   OTG mode on the Pi Zero W since he became usable again
>
> - Baruch adds the necessary Device Tree nodes to support the Raspberry
>   Pi GPIO expander which is controlled via the VC4 firmware
>
> - Hiroshi adds the missing LEDs on the Buffalo WZR-900DHP router
>
> - Eric adds the DPI hardware block into the BCM283x Device Tree include
>   file for future use when an actual panel is available
>
> - Florian updates the Northstar Plus platforms to use port 8 of the
>   internal switch as the CPU/management port since necessary code was
>   added in the b53 switch driver to support that

Pulled into next/dt, thanks!

      Arnd
