From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Apr 2015 17:03:20 +0100
Subject: [PATCH 2/3] ARM: sa1100: populate codec platform data with irq
In-Reply-To: <CALT56yMw77GPtHb3u+3fZ6DzRzGP2YXmoD_GWg2aD6ROCXep9Q@mail.gmail.com>
References: <1427989307-1805-1-git-send-email-dbaryshkov@gmail.com>
 <1427989307-1805-2-git-send-email-dbaryshkov@gmail.com>
 <20150402160023.GN24899@n2100.arm.linux.org.uk>
 <CALT56yMw77GPtHb3u+3fZ6DzRzGP2YXmoD_GWg2aD6ROCXep9Q@mail.gmail.com>
Message-ID: <20150402160320.GP24899@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 02, 2015 at 07:01:52PM +0300, Dmitry Eremin-Solenikov wrote:
> 2015-04-02 19:00 GMT+03:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > On Thu, Apr 02, 2015 at 06:41:46PM +0300, Dmitry Eremin-Solenikov wrote:
> >> For the sa11x0 boards that provide ucb1x00 codec platform data, provide
> >> the irq data.
> >
> > This isn't necessary.  The ucb1x00 can find its IRQ on its own.
> 
> Yes, it can. But if it's a static configuration, why can't it be
> configured statically?

Why change something that's worked for ages?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
