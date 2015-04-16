From: w@1wt.eu (Willy Tarreau)
Date: Thu, 16 Apr 2015 07:07:41 +0200
Subject: [PATCH] ARM: mvebu: armada-xp-openblocks-ax3-4: Disable internal
 RTC
In-Reply-To: <1429094447-4324-1-git-send-email-gregory.clement@free-electrons.com>
References: <1429094447-4324-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20150416050741.GB21981@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 15, 2015 at 12:40:47PM +0200, Gregory CLEMENT wrote:
> There is no crystal connected to the internal RTC on the Open Block
> AX3. So let's disable it in order to prevent the kernel probing the
> driver uselessly. Eventually this patches removes the following
> warning message from the boot log:
> "rtc-mv d0010300.rtc: internal RTC not ticking"

Now I understand why I was getting this message. Everytime it booted
I thought to myself "I have to debug this thing", now I understand
better.

Thanks,
Willy
