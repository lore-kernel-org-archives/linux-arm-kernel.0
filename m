From: greg@kroah.com (Greg KH)
Date: Fri, 20 Nov 2009 07:30:54 -0800
Subject: [PATCH 2/3] staging/dream: add missing include files
In-Reply-To: <20091120105726.GH11212@elf.ucw.cz>
References: <20091101222717.GB20740@elf.ucw.cz>
	<20091119225602.GC18710@kroah.com>
	<20091120105726.GH11212@elf.ucw.cz>
Message-ID: <20091120153054.GA23007@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2009 at 11:57:26AM +0100, Pavel Machek wrote:
> Where can I get the tree to diff against?
> gregkh-08-staging-2.6.32-rc7-git4.patch just reverts everything.
> 
> I guess I can extract it from
> ://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/series ...

Or grab the linux-next tree and branch from right before the "delete the
drivers/staging/dream/ directory" patch.

thanks,

greg k-h
