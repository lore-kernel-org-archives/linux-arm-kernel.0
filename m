From: olof@lixom.net (Olof Johansson)
Date: Mon, 26 May 2014 14:26:05 -0700
Subject: [GIT PULL] ARM: Keystone reset driver 3.16
In-Reply-To: <1400880597-7516-1-git-send-email-santosh.shilimkar@ti.com>
References: <1400880597-7516-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20140526212605.GQ27093@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 05:29:57PM -0400, Santosh Shilimkar wrote:
> Hi Arm-soc folks,
> 
> Please pull below keystone reset driver for 3.16 . To avoid merge conflict
> with earlier keystone-soc pull request[1], I have based the subject pull
> request on top of it. It merges cleanly with arm-soc 'next/soc2' head. Please
> apply it against 'next/soc2'. Thanks 

Hi,

I notice this driver doesn't have an ack from Philipp Zabel (cc:d here). That
would be appropriate. (Philipp, should there be a MAINTAINERS entry for you so
that get_maintainer works as expected here?)

I'd also prefer to see the driver and the other changes split up since we tend
to merge them through different branches. I think it's OK to just split in
those two for this merge.

I could do it for you (i.e. merge the first patch into next/drivers and the
rest into next/soc2 with the driver patch included on the bottom), but that
still wouldn't cover the ack from Philipp. If he replies to this email and says
he's ok with it going in I can still do it that way though. Philipp?



-Olof
