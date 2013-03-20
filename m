From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 20 Mar 2013 10:14:44 +0800
Subject: [PATCH V4 0/9] Add mandatory regulator for all users of
 pwm-backlight.
In-Reply-To: <1363719573-20926-1-git-send-email-achew@nvidia.com>
References: <1363719573-20926-1-git-send-email-achew@nvidia.com>
Message-ID: <20130320021442.GB20443@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 19, 2013 at 11:59:24AM -0700, Andrew Chew wrote:
> Many backlights are enabled via GPIO.  We can generalize the GPIO to a
> fixed regulator.
> 
I think we should push the series of "Runtime Interpreted Power
Sequences" moving forward, which should be useful this case and many
other cases as well.

http://thread.gmane.org/gmane.linux.kernel/1395912

Shawn
