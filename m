From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Tue, 31 Oct 2017 14:34:12 +0200
Subject: [PATCH 1/4] Revert "gpio: set up initial state from
 .get_direction()"
In-Reply-To: <a6c8b2ac-29de-4ec7-7b3f-fac1b5b16942@codeaurora.org>
References: <1509396602-1936-1-git-send-email-timur@codeaurora.org>
 <1509396602-1936-2-git-send-email-timur@codeaurora.org>
 <1509440926.10233.77.camel@linux.intel.com>
 <a6c8b2ac-29de-4ec7-7b3f-fac1b5b16942@codeaurora.org>
Message-ID: <1509453252.10233.113.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-10-31 at 07:28 -0500, Timur Tabi wrote:
> On 10/31/17 4:08 AM, Andy Shevchenko wrote:
> > Can you preserve the style and indentation of the commit?
> > Does checkpatch warn you about style? (It's apparently not a net
> > subsystem)
> 
> I ran checkpatch on it and it didn't complain.

Hmm... Okay.

> Also, I don't think that when reverting a patch, I am also supposed
> to 
> to fix cosmetic changes of the code that existed before the original
> patch.

Point taken. Up to Linus how to proceed, it's indeed cosmetic non-code
change.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
