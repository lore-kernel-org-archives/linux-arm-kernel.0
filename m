From: rnayak@ti.com (Rajendra Nayak)
Date: Wed, 14 Aug 2013 19:43:10 +0530
Subject: [PATCH 2/3] ARM: OMAP2+: Add support to parse optional clk info
 from DT
In-Reply-To: <20130814140807.GE13141@e106331-lin.cambridge.arm.com>
References: <1374560679-14666-1-git-send-email-rnayak@ti.com>
 <1374560679-14666-3-git-send-email-rnayak@ti.com>
 <CAGo_u6rfXpU1Wzn+oXqpAezNNtFb9pk=9RZxodGtBbZXVy+yJA@mail.gmail.com>
 <520B8409.5000708@ti.com> <520B88A0.6080806@ti.com>
 <20130814134904.GC13141@e106331-lin.cambridge.arm.com>
 <520B8D01.1040205@ti.com>
 <20130814140807.GE13141@e106331-lin.cambridge.arm.com>
Message-ID: <520B9076.2090702@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[]..
> 
> From the sounds of your other reply, the issue is that you're poking
> clocks for arbitrary devices, without knowing the semantics of those
> clocks, because you're doing it form outside the driver.

Thats right.
