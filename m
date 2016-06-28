From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 28 Jun 2016 09:52:45 +0800
Subject: [PATCH v3] ARM: dts: sun7i: Add BCM53125 switch nodes to the
 lamobo-r1 board
In-Reply-To: <1467074756-8402-1-git-send-email-f.fainelli@gmail.com>
References: <1467074756-8402-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <CAGb2v656uj8_AUUn7kayE8Vg+9njN1QMzt3YE92d7fhxKz58kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2016 at 8:45 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Now that we have a proper binding for Ethernet switches hanging off
> different buses, and a driver for the BCM53125 switch, add its Device
> Tree as a child MDIO node, at MDIO address 30 (Broadcom pseudo-PHY
> address) and describe the ports layout of the Lamobo R1 board.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
