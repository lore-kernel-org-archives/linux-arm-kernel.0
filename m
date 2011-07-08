From: johnlinn@comcast.net (johnlinn at comcast.net)
Date: Fri, 8 Jul 2011 21:56:57 +0000 (UTC)
Subject: PL330 alignment requirement questions
In-Reply-To: <1866031594.379248.1310161913147.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
Message-ID: <2034464824.379455.1310162217325.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm testing our PL330 with the driver/dma/pl330 driver and see some strangeness that's probably my own setup issue.

I'm also using drivers/dmatest to test it with memory to memory copies. I'm seeing that the copy alignment (copy_align) is not setup (it's 0) such that I see errors on some transfers at the end of the transfer.

If I setup the copy_align to be 3 or larger then I don't see these errors. This number doesn't make much sense to me and I'm digging into the details (seems like 4 would make sense).  I just wanted to see if anyone had tested with dmatest and seen anything similar.

Thanks,
John
