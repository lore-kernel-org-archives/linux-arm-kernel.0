From: ryan.harkin@linaro.org (Ryan Harkin)
Date: Mon, 24 Sep 2012 08:07:54 +0100
Subject: [RFC PATCH 1/3] amba-clcd: Add Device Tree support to amba-clcd
 driver
In-Reply-To: <20120921121903.GE15609@n2100.arm.linux.org.uk>
References: <1348070666-9153-1-git-send-email-ryan.harkin@linaro.org>
 <1348070666-9153-2-git-send-email-ryan.harkin@linaro.org>
 <20120921114345.GE24458@pengutronix.de>
 <20120921121903.GE15609@n2100.arm.linux.org.uk>
Message-ID: <CAD0U-hKviTANE+88vh_UUkXijJOxpM3gXmgQW4oOegMnav9Zqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for all the comments.

Pawel, good point about the framebuffer.  Fixing this will also
address one of Russell's concerns.  I don't know how to use a phandle,
so I have some reading to do.

Russell, all good points and exactly the type of feedback I needed.
I'll re-work your suggestions into my code and re-post a V2 of the
patches.

Sascha, I see your point.  I'll work on the feedback above first
before getting to looking at how to handle the thread you linked to.

Thanks all,

Regards,
Ryan.
