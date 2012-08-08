From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 8 Aug 2012 14:38:04 +0000
Subject: [PATCH 2/6] ARM: pxa remove irq_to_gpio from eeti_ts driver
In-Reply-To: <50227615.1090907@gmail.com>
References: <1344430493-5304-1-git-send-email-arnd@arndb.de>
 <201208081419.17181.arnd@arndb.de> <50227615.1090907@gmail.com>
Message-ID: <201208081438.04931.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 August 2012, Daniel Mack wrote:
> > 
> > I've taken your patch instead now, 
> 
> Will that go to some other tree than linux-input now?

I have it in the arm-soc tree for now, but I don't really care
which tree it goes through, as long as it does. I've kept a
version of this patch in one branch with random fixes that
I try to clear out now.

Other than that, I'm fine with whatever Dmitry prefers.

	Arnd
