From: wpdster@gmail.com (Patrick Doyle)
Date: Wed, 20 Apr 2016 15:55:42 -0400
Subject: Looking for information on modern(ish) use of spidev
Message-ID: <CAF_dkJDRaidOF5p1B+ssx=SKgUHonMj5TbG2mT3wE5bOdDw69g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Can anybody point me at a relatively recent tutorial/explanation of
the current usage of spidev?

What should I put in my device tree?  Should I modprobe spidev?

I have 2 devices hanging off a SPI bus and I would like to verify that
they work.  All I need to be able to do is to transfer some data to
and from the devices and see that it looks reasonable.  I'll figure
out the correct device driver later, but I just want to see some
transactions on the bus today.

What's the simplest way to do that?  If spidev isn't the right tree to
climb, where should I look instead?

--wpd
