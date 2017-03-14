From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 14 Mar 2017 22:51:06 +0100
Subject: [PATCH 1/2] ARM: dts: BCM5301X: Specify serial console parameters
In-Reply-To: <5776ba44-e280-9711-1b05-1c79556884e2@broadcom.com>
References: <20170314075830.2247-1-zajec5@gmail.com>
 <20170314122650.GV15842@lunn.ch>
 <3345fb38-fbea-141e-6ad2-a3341e2c31fe@gmail.com>
 <CAC3K-4qQzX37BLD2N-N-vDwSk=H_rF5PzoMM+GM=Z935QFVnXw@mail.gmail.com>
 <9f5a0381-aae6-9ac2-56f3-9eb78ecfd819@broadcom.com>
 <CAC3K-4pAzs5fXNB=ZpyzYZnTENa=c0v81GVn7WpW53K7GV9UOg@mail.gmail.com>
 <5776ba44-e280-9711-1b05-1c79556884e2@broadcom.com>
Message-ID: <20170314215106.GB22176@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >Unfortunately, there is not a common bootloader.  CFE is used for the
> >4708/9 boards, and u-boot is used for the 5301x boards.
> OK, little different situation not having a boot rom with console
> output enforcing all designs to use the same UART.
> Do both of the bootloaders happen to use the same UART and all the
> boards are designed to use the same UART?

You need to be a little bit careful here. Some vendor could use a
different UART in there design, use some other bootloader,
etc. Somebody in the community might want to throw out uboot and use
barebox etc....

Device tree does allow .dtsi properties to be over written, so it is
not an issue in practice.

    Andrew
