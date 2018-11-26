From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 26 Nov 2018 06:58:48 +0100
Subject: [PATCH 08/13] ARM: dts: rv1108: Fix the PMU interrupt number
In-Reply-To: <20181125211907.9895-8-otavio@ossystems.com.br>
References: <20181125211907.9895-1-otavio@ossystems.com.br>
 <20181125211907.9895-8-otavio@ossystems.com.br>
Message-ID: <3361921.c4PKPBIJKP@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Otavio,

Am Sonntag, 25. November 2018, 22:19:02 CET schrieb Otavio Salvador:
> According to the Rockchip vendor tree the PMU interrupt number is
> 76, so fix it accordingly.
> 
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
> Signed-off-by: Fabio Berton <fabio.berton@ossystems.com.br>

looks ok, especially as the TRM I have doesn't list neither irqs :-)
But please explain the second Signed-off by Fabio?

If Fabio is the original author, the patch From should reflect that
and the Signed-off-by lines should be swapped. As it is now
I would expect Fabio being the one sending the patches.
Or is it supposed to be a "Co-developed-by:"?
See Documentation/process/5.Posting.rst.


Thanks
Heiko
