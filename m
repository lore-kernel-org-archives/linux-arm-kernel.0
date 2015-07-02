From: pawelo@king.net.pl (Paul Osmialowski)
Date: Thu, 2 Jul 2015 23:42:18 +0200 (CEST)
Subject: [PATCH v2 3/9] arm: twr-k70f120m: clock driver for Kinetis SoC
In-Reply-To: <1861313.aMcV1xHCIq@wuerfel>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
 <alpine.LNX.2.00.1507011756140.14440@localhost.localdomain>
 <alpine.LNX.2.00.1507021206410.13210@localhost.localdomain>
 <1861313.aMcV1xHCIq@wuerfel>
Message-ID: <alpine.LNX.2.00.1507022338070.28322@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, 2 Jul 2015, Arnd Bergmann wrote:

> I wonder if you could move out the fixed rate clocks into their own
> nodes. Are they actually controlled by the same block? If they are
> just fixed, you can use the normal binding for fixed rate clocks
> and only describe the clocks that are related to the driver.
>
> 	Arnd
>

In my view having these clocks grouped together looks more convincing. 
After all, they all share the same I/O regs in order to read 
configuration.

Thanks,
Paul
