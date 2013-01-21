From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 21 Jan 2013 10:30:29 -0800
Subject: [GIT PULL] arm-soc: Xilinx zynq serial changes for v3.9
In-Reply-To: <CAHTX3dJGHK7nO2tx_kUWLwhpgNsCwtnjXAJnRFUOHVx2uE589Q@mail.gmail.com>
References: <CAHTX3dJGHK7nO2tx_kUWLwhpgNsCwtnjXAJnRFUOHVx2uE589Q@mail.gmail.com>
Message-ID: <20130121183029.GA21326@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 06:19:03PM +0100, Michal Simek wrote:
> Hi Arnd, Olof and Greg,
> 
> I have two patches for xilinx uartps serial driver (the second one fix
> one issue in the first one).
> These patches has been sent to arm mailing list and also to
> device-tree mailing list.
> 
> There is a change in zynq dtsi that's why I think it can go through
> arm-soc tree.
> Please let me know if this should go through Greg serial tree.

If they fix serial driver issues, I have no problem taking them through
my serial tree, just send them on as patches and I will be glad to queue
them up.

thanks,

greg k-h
