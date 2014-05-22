From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 22 May 2014 15:18:28 +0200
Subject: [PATCH 0/5] net: macb: Fixes
In-Reply-To: <1399243382-12528-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1399243382-12528-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <20140522131827.GN3582@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/05/2014 at 15:42:57 -0700, Soren Brinkmann wrote :
> 
> Hi Nicolas,
> 
> I think I found the cause of the issue I told you about. Looks like
> driver and HW are racing (a few more details in the commit message).
> On my way finding that, I found a few more minor issues which are fixed
> in the first patches.
> The last one is "fixing" the actual race. I don't know if I overlooked
> anything here, but this seems to work fine on Zynq.
> 

Tested on at91sam9g45ek with iperf showing good performances. For the
whole series:
Tested-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
