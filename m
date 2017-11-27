From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Mon, 27 Nov 2017 11:59:22 -0700
Subject: [PATCH] rtc: Allow rtc drivers to specify the tv_nsec value for
 ntp
In-Reply-To: <20171127174323.GK31757@n2100.armlinux.org.uk>
References: <20171013175433.GA22062@obsidianresearch.com>
 <20171123095456.lkc4nkuzsd2q26mm@piout.net>
 <20171123150439.GB18754@mellanox.com>
 <20171127154316.GG31757@n2100.armlinux.org.uk>
 <20171127174323.GK31757@n2100.armlinux.org.uk>
Message-ID: <20171127185922.GE13962@mellanox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 05:43:23PM +0000, Russell King - ARM Linux wrote:

> Having been through the conflict mess and come out with a resolution,
> I think it might be okay, with the exception of the missing explanation
> in drivers/rtc/class.c.  I do need to run some tests on it to make sure
> though.

Okay thanks, let me know if more is needed.

Jason
