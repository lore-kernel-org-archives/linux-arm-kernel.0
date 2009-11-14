From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 14 Nov 2009 08:52:36 +0000
Subject: Kernel Panic while booting arm-pb1176
In-Reply-To: <261969.43457.qm@web7602.mail.in.yahoo.com>
References: <261969.43457.qm@web7602.mail.in.yahoo.com>
Message-ID: <20091114085236.GA19214@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 14, 2009 at 02:05:52PM +0530, abhijeet tripathi wrote:
> I am attaching the console logs.

I think it's one for networking people.  Looks to me like some MDIO
device is being registered twice.

Be sure to send them the full kernel boot log as well.
