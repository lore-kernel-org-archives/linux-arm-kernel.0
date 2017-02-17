From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 17 Feb 2017 10:43:25 -0800
Subject: [PATCH] staging: bcm2835-audio: bcm2835.h: fix various coding
 style issues
In-Reply-To: <1487356776-11449-1-git-send-email-adanhawthorn@gmail.com>
References: <1487356776-11449-1-git-send-email-adanhawthorn@gmail.com>
Message-ID: <20170217184325.GB11935@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2017 at 01:39:07PM -0500, Nathan Howard wrote:
> The following coding style issues (as per checkpatch.pl) were resolved.
> 
> WARNING: Block comments use * on subsequent lines
> WARNING: Prefer [subsystem eg: netdev]_info([subsystem]dev, ...
> WARNING: Missing a blank line after declarations
> WARNING: Use of volatile is usually wrong:...
> WARNING: line over 80 characters
> CHECK: Concatenated strings should use spaces between elements
> CHECK: Macro argument 'vol' may be better as '(vol)' to avoid precedence issues

Please only do one thing per patch, and no, "fix style issues" is not
one thing :(

This should be a patch series, one per type of thing done.

thanks,

greg k-h
