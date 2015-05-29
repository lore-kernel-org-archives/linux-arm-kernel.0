From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 May 2015 14:56:22 +0200
Subject: [GIT PULL] ARM: mediatek: soc updates for v4.2
In-Reply-To: <CABuKBe+y5Em77WbKUu3YHAuwdc7n_ybLe-Eii8G1H-EQ0xZrRg@mail.gmail.com>
References: <CABuKBe+y5Em77WbKUu3YHAuwdc7n_ybLe-Eii8G1H-EQ0xZrRg@mail.gmail.com>
Message-ID: <2169528.AHb4teykcE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 May 2015 17:09:43 Matthias Brugger wrote:
> - pmic wrapper: fix clock handling
> - pmic wrapper: fix state machine
> - pmic wrapper: fix compile dependency
> 

Merged into next/drivers now.

It looks like these are all bug fixes, and I wonder if they
should be merged for 4.1 and possibly backports instead.
Can you clarify?

	Arnd
