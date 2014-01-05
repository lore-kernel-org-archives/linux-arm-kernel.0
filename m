From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Sun, 5 Jan 2014 16:07:46 -0700
Subject: [PATCH v2 1/2] ARM: mvebu: Add support to get the ID and the
 revision of a SoC
In-Reply-To: <52C99851.70806@gmail.com>
References: <1388743185-24822-1-git-send-email-gregory.clement@free-electrons.com>
 <1388743185-24822-2-git-send-email-gregory.clement@free-electrons.com>
 <201401051525.52459.arnd@arndb.de> <20140105154023.GA2048@lunn.ch>
 <20140105172756.GA11280@obsidianresearch.com>
 <52C99851.70806@gmail.com>
Message-ID: <20140105230746.GB11280@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 05, 2014 at 06:37:21PM +0100, Sebastian Hesselbarth wrote:

> If you mean clock-gated with "powered down", the code is safe. It
> enables the clock gate prior reading from the controller. Or is there
> another way to power down the controller, so you cannot read from the
> controller registers?

There is a clock gate and a power down on kirkwood at least, Linux has
no code for controlling the powerdown

In any event, I think processing a disabled DT node is not great..

Jason
