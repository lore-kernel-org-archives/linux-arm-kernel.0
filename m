From: tony@atomide.com (Tony Lindgren)
Date: Tue, 1 May 2018 08:30:08 -0700
Subject: [PATCH v3] ARM: dts: Add am335x-pocketbeagle
In-Reply-To: <20180417171404.13624-1-robertcnelson@gmail.com>
References: <20180417171404.13624-1-robertcnelson@gmail.com>
Message-ID: <20180501153008.GD98604@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Robert Nelson <robertcnelson@gmail.com> [180417 10:15]:
> PocketBeagle is an ultra-tiny-yet-complete open-source USB-key-fob computer.
> 
> This board family can be indentified by the A335PBGL in the at24 eeprom:
> A2: [aa 55 33 ee 41 33 33 35  50 42 47 4c 30 30 41 32 |.U3.A335PBGL00A2|]
> 
> http://beagleboard.org/pocket
> https://github.com/beagleboard/pocketbeagle
> 
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> CC: Tony Lindgren <tony@atomide.com>
> CC: Jason Kridner <jkridner@beagleboard.org>
> CC: Drew Fustini <drew@beagleboard.org>
> CC: Peter Robinson <pbrobinson@redhat.com>
> ---
> Changes in v3:
> - Fix: Board eeprom in subject message. (accidently copied PocketBone)
> Changes in v2:
> - Use SPDX tags.
> - Use eeprom at 50, remove repeated node and fix  and remove '_' to fix node_name_chars_strict Warning
> - Fix: PocketBeagle Name in Subject (not PocketBeagle Blue)
> - Fix: leds remove '_' to fix node_name_chars_strict warning
> - Fix: node_name_chars_strict pinmux_*_pins label's.

Thanks applying into omap-for-v4.18/dt.

Tony
