From: rjui@broadcom.com (Ray Jui)
Date: Fri, 16 Jan 2015 16:58:18 -0800
Subject: Directory for platform specific power management code
Message-ID: <54B9B3AA.5050201@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Can someone please tell me the best location for platform specific power
management code, e.g., the code that puts a specific SoC into deep sleep.

I'm working on a project for an SoC called Cygnus from Broadcom. I think
arch/arm/mach-bcm/* is the best location, but given that the trend is to
move code from arch directories into drivers/* (e.g., drivers/clk/*), I
thought I would double check here.

Thanks,

Ray
