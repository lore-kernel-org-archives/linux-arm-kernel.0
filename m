From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Tue, 31 Oct 2017 21:05:57 +0200
Subject: [PATCH 2/4] gpiolib: add bitmask for valid GPIO lines
In-Reply-To: <02208047-38c8-f97b-5c53-6cced7bdecc6@codeaurora.org>
References: <1509396602-1936-1-git-send-email-timur@codeaurora.org>
 <1509396602-1936-3-git-send-email-timur@codeaurora.org>
 <1509441149.10233.80.camel@linux.intel.com>
 <02208047-38c8-f97b-5c53-6cced7bdecc6@codeaurora.org>
Message-ID: <1509476757.10233.143.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-10-31 at 13:54 -0500, Timur Tabi wrote:
> On 10/31/2017 04:12 AM, Andy Shevchenko wrote:
> > Instead of mangling this function wouldn't be better to introduce a
> > separate one for line and perhaps a third one which calls them both?
> 
> The diff is convoluted, but the end result is clean:

> Is this acceptable?

I also put in the comment the following:

--- 8< --- 8< --- 8< ---

...for my opinion it will drastically increase readability and reduce
diff as well (better for review).

--- 8< --- 8< --- 8< ---

The decision is up to Linus. I simple shared my opinion.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
