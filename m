From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 22 Feb 2016 15:16:17 +0100
Subject: [PATCH 2/3] clk: mvebu: add AP806 core clock driver
In-Reply-To: <20160222091423.4756a579@free-electrons.com>
References: <1455521698-7905-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1455521698-7905-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160222025357.GE15973@rob-hp-laptop>
 <20160222091423.4756a579@free-electrons.com>
Message-ID: <20160222141617.GA14970@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Such information will come later, and we can rework the drivers and DT
> bindings accordingly. Those DT bindings cannot be stable, as the
> platform is under heavy development and we'll probably discover some
> issues down the road.

Hi Thomas

Maybe add a big fat warning that the bindings are unstable, and the DT
blob must be kept in sync with the kernel?

     Andrew
