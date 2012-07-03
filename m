From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 3 Jul 2012 15:12:55 +0200
Subject: [PATCH 0/3] ARM: dts: dove: Basic devicetree support for Marvell
 Dove
In-Reply-To: <4FF2EDB0.3040707@googlemail.com>
References: <1341318868-24567-2-git-send-email-sebastian.hesselbarth@googlemail.com>
 <20120703125017.GB17534@lunn.ch> <4FF2EDB0.3040707@googlemail.com>
Message-ID: <20120703131255.GC17534@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I am fine with 'marvell' instead of 'mrvl'. But the name change
> has not been commited to arm-soc, yet? I can create a patch to
> rename all occurrences of mrvl to marvell if you like.
> 

Hi Sebastian

Jason has been working on this. Not sure what the status is.

I also have patches for interrupt controllers, GPIO controls, and a
few of the other device drivers. I will try to post them ASAP for a
second review round. It would be good if you can test them out on your
little cube.

       Thanks
              Andrew
