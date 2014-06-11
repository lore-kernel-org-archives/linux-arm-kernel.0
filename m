From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Jun 2014 10:07:04 +0200
Subject: [PATCH v5 2/2] i2c: sunxi: add P2WI (Push/Pull 2 Wire Interface)
 controller support
In-Reply-To: <53980AD4.2080001@free-electrons.com>
References: <1402408036-5235-1-git-send-email-boris.brezillon@free-electrons.com>
 <13219561.hrRmVFjmAv@wuerfel> <53980AD4.2080001@free-electrons.com>
Message-ID: <5138962.eWJk3tfacf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 June 2014 09:52:52 Boris BREZILLON wrote:
> You mean in my commit message ?
> I thought it was already explaining the subtle differences between P2WI
> and the SMBus protocols.
> 
> What would you like me to add to this explanation ?
> Something about the I2C to P2WI initialization part ?
> 

What I'd like to see is a mention of previous discussion that
concluded that it should be an i2c driver rather than a new
type of driver, and why.

	Arnd
