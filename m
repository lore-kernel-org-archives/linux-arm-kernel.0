From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 23 Sep 2010 13:19:13 +0200
Subject: [PATCH] arm: fix use of clock disable on idle for AT91x40 devices
In-Reply-To: <201009211039.o8LAde8Q024441@goober.internal.moreton.com.au>
References: <201009211039.o8LAde8Q024441@goober.internal.moreton.com.au>
Message-ID: <20100923111913.GA32018@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20:39 Tue 21 Sep     , Greg Ungerer wrote:
> The simpler AT91x40 processors do not have the same power management
> controller as the new AT91 devices. They do have a simpler power
> controller module that we can use to disable the CPU clock at idle
> time. Add code to support that.
> 
> Signed-off-by: Greg Ungerer <gerg@uclinux.org>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
