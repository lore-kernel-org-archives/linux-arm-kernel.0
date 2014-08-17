From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Sun, 17 Aug 2014 16:20:49 -0400
Subject: [PATCHv5 1/2] pwm: Add Allwinner SoC support
In-Reply-To: <CAKON4OyywLZ1bktuUbjagVvzjr0bJf7p9xpR7jeOq6FBe+6P=g@mail.gmail.com>
References: <1400523003-27082-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1400523003-27082-2-git-send-email-alexandre.belloni@free-electrons.com>
 <20140617232605.GB25525@mithrandir>
 <20140623170115.GA11436@piout.net>
 <CAKON4OyywLZ1bktuUbjagVvzjr0bJf7p9xpR7jeOq6FBe+6P=g@mail.gmail.com>
Message-ID: <CAKON4Oxuqs0EXqhLucx6gMm5jnFWrhLaAutzrCR8GTDh11xCvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

New version that adds better support for the A10 plus it fixes an
issue in the previous version.

Note that the A10 does not support the 24Mhz bypass mode.

-- 
Jon Smirl
jonsmirl at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: pwm
Type: application/octet-stream
Size: 18574 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140817/f59907ba/attachment-0001.obj>
