From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 25 Nov 2015 15:46:45 +0100
Subject: Strange message from Kirkwood pinctrl driver
In-Reply-To: <CACRpkdah4w-=qHS+q_=Ab-RiJyvbCKY-Rp5Ya0x+F=3DL2iuBA@mail.gmail.com>
References: <CACRpkdah4w-=qHS+q_=Ab-RiJyvbCKY-Rp5Ya0x+F=3DL2iuBA@mail.gmail.com>
Message-ID: <20151125144645.GE11384@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 11:27:46AM +0100, Linus Walleij wrote:
> Hi Sebastian,
> 
> trying to use the Kirkwood pinctrl driver with compatible =
> "marvell,88f6192-pinctrl";
> on a Pogoplug series 4 yields the following message when instantiating
> the driver:
> 
> kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 36
> kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 37
> kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 38
> kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 39
> kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 40

Hi Linus

Humm, interesting. I don't remember it doing that before. I will look
into this in the next couple of days.

     Andrew
