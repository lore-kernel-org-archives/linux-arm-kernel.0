From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Mar 2013 23:12:29 +0000
Subject: My git tree, and tsinghua.edu.cn
Message-ID: <20130305231229.GM17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've just blocked access from a Chinese IP to my git tree this evening.
Why?

It seems someone has decided it's a good idea to poll my git tree from
anything between once a minute and once every few minutes - constantly,
24 hours a day.

Now, it's not like I push updates to the git tree anywhere near that
frequency - once an hour is probably the minimum sensible interval.
So, while not really a problem, it's a horrid waste of resources.

However, as the machine threw a disk last night, this kind of sillyness
is something we don't need at the moment.  So, if you're at tsinghua.edu.cn
and you find you can no longer pull my git tree, you now know why.

Please increase your polling period, and send me a mail to remove the
block.

Thanks.
