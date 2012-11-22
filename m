From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Nov 2012 09:31:01 +0000
Subject: [PATCH 1/3] CLK: uninline clk_prepare() and clk_unprepare()
In-Reply-To: <20121122032407.21126.49680@nucleus>
References: <1353403339-11679-1-git-send-email-dmitry.torokhov@gmail.com>
 <1353403339-11679-2-git-send-email-dmitry.torokhov@gmail.com>
 <CAKohpo=B_7rVwePziyNe0rTMokcib_FgEN28cy4nByAzbUyaqg@mail.gmail.com>
 <20121121204324.21126.99677@nucleus>
 <20121121205424.GA25470@core.coreip.homeip.net>
 <20121121223859.GQ3290@n2100.arm.linux.org.uk>
 <20121122021750.GD25470@core.coreip.homeip.net>
 <20121122031117.GE25470@core.coreip.homeip.net>
 <20121122032407.21126.49680@nucleus>
Message-ID: <20121122093101.GB5764@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 07:24:07PM -0800, Mike Turquette wrote:
> Looks right to me.  Just need to remove the select from IMX as well.

Then you don't understand HAVE_CLK_PREPARE.
