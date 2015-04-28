From: lee@kernel.org (Lee Jones)
Date: Tue, 28 Apr 2015 10:22:05 +0100
Subject: [PATCH 2/2] ARM: BCM2835: Move the restart/power_off handling to
 the WDT driver.
In-Reply-To: <553EE4EC.1000403@roeck-us.net>
References: <1429902534-2348-1-git-send-email-eric@anholt.net>
 <1429902534-2348-2-git-send-email-eric@anholt.net>
 <20150427160432.GD5701@roeck-us.net>
 <20150427160517.GA11074@roeck-us.net>
 <877fsx9nd6.fsf@eliezer.anholt.net> <553EE4EC.1000403@roeck-us.net>
Message-ID: <20150428092205.GG11956@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 27 Apr 2015, Guenter Roeck wrote:

> On 04/27/2015 04:12 PM, Eric Anholt wrote:
> >Guenter Roeck <linux@roeck-us.net> writes:
> >
> >>On Mon, Apr 27, 2015 at 09:04:32AM -0700, Guenter Roeck wrote:
> >>>On Fri, Apr 24, 2015 at 12:08:54PM -0700, Eric Anholt wrote:
> >>>>Since the WDT is what's used to drive restart and power off, it makes
> >>>>more sense to keep it there, where the regs are already mapped and
> >>>>definitions for them provided.  Note that this means you may need to
> >>>>add CONFIG_BCM2835_WDT to retain functionality of your kernel.
> >>>>
> >>>>Signed-off-by: Eric Anholt <eric@anholt.net>
> >>>>Cc: linux-watchdog at vger.kernel.org
> >>>
> >>>The patch will require a rebase to v4.0-rc1.
> >>>
> >>s/4.0/4.1/
> >
> >It will?  It seems to work fine, and the diff's the same.  Is there some
> >new thing you were expecting in a rebase?
> >
> All I can say is that it didn't apply for me. Maybe someone else has more luck.

I won't even try without a WDT Ack. ;)
