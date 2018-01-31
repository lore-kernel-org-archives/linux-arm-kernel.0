From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 30 Jan 2018 19:03:29 -0800
Subject: [patch v18 0/4] JTAG driver introduction
In-Reply-To: <1517236305-4880-1-git-send-email-oleksandrs@mellanox.com>
References: <1517236305-4880-1-git-send-email-oleksandrs@mellanox.com>
Message-ID: <ff739c26-d3b2-3df7-e751-fbf037ae96d1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/29/2018 06:31 AM, Oleksandr Shamray wrote:
> When a need raise up to use JTAG interface for system's devices
> programming or CPU debugging, usually the user layer
> application implements jtag protocol by bit-bang or using a 
> proprietary connection to vendor hardware.
> This method can be slow and not generic.
>  
> We propose to implement general JTAG interface and infrastructure
> to communicate with user layer application. In such way, we can
> have the standard JTAG interface core part and separation from
> specific HW implementation.
> This allow new capability to debug the CPU or program system's 
> device via BMC without additional devices nor cost. 

Oleksandr, you have completed dodged my questions here:

https://lkml.org/lkml/2017/12/25/163

can you try to respond to some of these questions please?
-- 
Florian
