From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 9 Aug 2017 16:31:28 +0200
Subject: [patch v2 0/2]
In-Reply-To: <1502115467-1735-1-git-send-email-oleksandrs@mellanox.com>
References: <1502115467-1735-1-git-send-email-oleksandrs@mellanox.com>
Message-ID: <20170809143128.GI30723@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 07, 2017 at 05:17:45PM +0300, Oleksandr Shamray wrote:
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
> to communicate with user layer application. 

Hi Oleksandr

You might find this discussion interesting:

https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2017-August/004721.html

You are defining a new ABI here, so linux-abi should be involved in
the discussion of these patches.

    Andrew
