From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 17 Sep 2014 08:59:30 -0400
Subject: [PATCH 6/7] irqchip: add irq-asm9260 driver
In-Reply-To: <54167EB6.2020008@rempel-privat.de>
References: <1410646408-28901-1-git-send-email-linux@rempel-privat.de>
 <1410646408-28901-7-git-send-email-linux@rempel-privat.de>
 <20140914073738.GQ21986@titan.lakedaemon.net>
 <54167EB6.2020008@rempel-privat.de>
Message-ID: <20140917125930.GA16945@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 15, 2014 at 07:52:54AM +0200, Oleksij Rempel wrote:
> How about irq priority system which provide this controller, do it make
> sense to implement it? Or it es better to allow kernel make needed decision?

Let's keep it simple for now.  If you discover a problem down the road,
we can address it at the time.

thx,

Jason.
