From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Feb 2012 14:04:06 +0000
Subject: [PATCH 0/7] share sa1100 rtc driver to arch-mmp
In-Reply-To: <CAN1soZyL=659A2gLp_tLKaUTnBkLi1w0NgVq4SD4in1JE1v4VA@mail.gmail.com>
References: <201202221350.00100.arnd@arndb.de>
 <CAN1soZxTutYQ=uU0y_AvBTn37es+8tBU=1L6eKtJDUNONgwHFw@mail.gmail.com>
 <87r4xmygb7.fsf@free.fr>
 <CAN1soZx84dmAVz-Kyv18+fjOJyzvun7fpbXA+rYb6xeEhQbXtQ@mail.gmail.com>
 <87booqx771.fsf@free.fr>
 <CAN1soZxbDKHjMxjNjDOXk8Ko9AyJEDGFV1XpqpiJCaL9ikNEdg@mail.gmail.com>
 <20120223100019.GK22562@n2100.arm.linux.org.uk>
 <CAN1soZwBSHJcFWojPXTY7mDdD4vw85ABoXCk5uufcTNiQzh6_A@mail.gmail.com>
 <20120223104937.GP22562@n2100.arm.linux.org.uk>
 <CAN1soZyL=659A2gLp_tLKaUTnBkLi1w0NgVq4SD4in1JE1v4VA@mail.gmail.com>
Message-ID: <20120223140406.GX22562@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 09:32:30PM +0800, Haojian Zhuang wrote:
> OK. I can keep the hard coded register definition and format patch right now.
> The rtc register base of arch-sa1100, arch-pxa, arch-mmp are
> different. It means
> that I need use #ifdef CONFIG_ARCH to distinguish different arch. But I have a
> question that removing #ifdef CONFIG_ARCH in driver code is our
> target, isn't it?

Yes, but we can't do that until the pxa-rtc vs sa1100-rtc issue is
resolved.
