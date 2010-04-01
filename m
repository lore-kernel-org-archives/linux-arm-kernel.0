From: gregkh@suse.de (Greg KH)
Date: Thu, 1 Apr 2010 09:51:44 -0700
Subject: Memory corruption with 2.6.32.10, but not with 2.6.34-rc3
In-Reply-To: <20100401132156.GJ30807@buzzloop.caiaq.de>
References: <20100401132156.GJ30807@buzzloop.caiaq.de>
Message-ID: <20100401165144.GB1138@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 01, 2010 at 03:21:56PM +0200, Daniel Mack wrote:
> 
> I can cherry-pick things if anyone pin-points something and run
> lont-time tests again. Any pointer appreciated.

Oh, how about running 'git bisect' to try to find the solution?  Just
remember to reverse 'good' and 'bad' for when you tell git bisect what
the results are.

thanks,

greg k-h
