From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 2 Aug 2017 16:12:09 +0200
Subject: [patch v1 0/2] JTAG driver introduction
In-Reply-To: <1501679918-20486-1-git-send-email-oleksandrs@mellanox.com>
References: <1501679918-20486-1-git-send-email-oleksandrs@mellanox.com>
Message-ID: <20170802141209.GB25781@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 02, 2017 at 04:18:36PM +0300, Oleksandr Shamray wrote:
> When a need raise up to use JTAG interface for system's devices
> programming or CPU debugging, it could be done from the external
> JTAG master controller.
>  
> For such purpose, usually the user layer
> application implements jtag protocol or using a proprietary
> connection to vendor hardware.
> This method is slow and not generic.
>  
> We propose to implement general JTAG interface and infrastructure
> to communicate with user layer application. In such way, we can
> have the standard JTAG interface core part and separation from
> specific HW implementation.
> This allow new capability to debug the CPU or program system's 
> device via BMC without additional devices nor cost. 

Hi Oleksandr

Do you have patches for OpenOCD? Or maybe i should ask it another way,
what user space tools are you using?

Thanks
	Andrew
