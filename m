From: joshc@codeaurora.org (Josh Cartwright)
Date: Thu, 25 Sep 2014 14:01:35 -0500
Subject: [PATCH v3 2/3] watchdog: qcom: document device tree bindings
In-Reply-To: <20140925184314.GC12340@roeck-us.net>
References: <cover.1411667144.git.joshc@codeaurora.org>
 <f49033de078aff9112fb8fa6fa4331e16998edf2.1411667144.git.joshc@codeaurora.org>
 <20140925184314.GC12340@roeck-us.net>
Message-ID: <20140925190135.GK868@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 11:43:14AM -0700, Guenter Roeck wrote:
> On Thu, Sep 25, 2014 at 12:48:52PM -0500, Josh Cartwright wrote:
[..]
> > +- timeout-sec : shall contain the default watchdog timeout in seconds,
> > +                if unset, the default timeout is 30 seconds
> 
> Hi Josh,
> 
> timeout-sec is optional, not mandatory.

Indeed, I made this change in v2, but didn't reflect it in the document.
Good catch. Will fix.

  Josh

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
