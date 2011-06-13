From: johnlinn@comcast.net (johnlinn at comcast.net)
Date: Mon, 13 Jun 2011 21:31:59 +0000 (UTC)
Subject: DMA setup for ARM platform with hole low in memory
In-Reply-To: <1347566644.1505253.1308000163643.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
Message-ID: <315025466.1505794.1308000719987.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm trying to decide the best way to setup this ARM platform DMA to deal with the fact that the lowest 512K of memory can not be DMAed into.  The rest of memory space is fine.


>From bogus@does.not.exist.com  Wed Jun  1 12:03:18 2011
From: bogus@does.not.exist.com ()
Date: Wed, 01 Jun 2011 16:03:18 -0000
Subject: No subject
Message-ID: <mailman.24.1308000730.24103.linux-arm-kernel@lists.infradead.org>

Am I missing the easier way?

Thanks,
John
