From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 2 Jan 2017 22:24:32 +0100
Subject: [PATCH 0/2] ARM: orion5x: Move micon code to a MFD driver
In-Reply-To: <20161229000137.5553-1-f.fainelli@gmail.com>
References: <20161229000137.5553-1-f.fainelli@gmail.com>
Message-ID: <20170102212432.GB15213@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 28, 2016 at 04:01:35PM -0800, Florian Fainelli wrote:
> Hi all,
> 
> This patch series removes some duplicate code between the Kurobox and the
> Terastation Pro 2 since they both use the same on-board microcontroller (micon)
> attached to their UART1 for system restart.
> 
> Future patches will add support for the LEDs, temperature, FAN that the micro
> controller provides.

Hi Florian

Are you coordinating with Roger Shimizu <rogershimizu@gmail.com>. He
has a conflicting patchset doing something similar/different.

    Andrew
