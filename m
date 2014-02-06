From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 6 Feb 2014 22:55:13 +0800
Subject: v3.14-rc1 locking bug in system suspend
In-Reply-To: <20140205145408.GA3708@S2101-09.ap.freescale.net>
References: <20140205145408.GA3708@S2101-09.ap.freescale.net>
Message-ID: <20140206145509.GB6610@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 05, 2014 at 10:54:10PM +0800, Shawn Guo wrote:
> I start seeing the following locking bug on IMX6 with suspend operation
> after moving to v3.14-rc1.  Before I start looking into the issue, I
> would like to confirm if it's an IMX specific problem or one seen on
> other platforms.  Please ask if you need more info.

Sorry.  This is not a new bug of v3.14-rc1.  It's been there with
v3.13-rc for a while.  It looks like there is something wrong in the
use of power_lock in struct snd_card.  Will dig into it.

Shawn
