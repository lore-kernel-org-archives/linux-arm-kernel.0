From: gregkh@linuxfoundation.org (Greg KH)
Date: Fri, 16 Nov 2012 05:17:28 -0800
Subject: sysfs crashes while recursively checking file permissions
In-Reply-To: <50937B34.6050502@codeaurora.org>
References: <50937B34.6050502@codeaurora.org>
Message-ID: <20121116131728.GA30613@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 02, 2012 at 01:20:12PM +0530, Chintan Pandya wrote:
> Hi,
> 
> I am running one test on my ARM system which checks the sysfs file
> system's whole directory recursively and checks its file permission.
> While I perform this test, I face random (as in varies the nature of
> crash sometimes) crashes like one mentioned below.
> 
> 
> <1>[   67.442660] Unable to handle kernel paging request at virtual
> address efd3d794
> 
> <1>[   67.448840] pgd = da364000
> 
> <1>[   67.451529] [efd3d794] *pgd=00000000
> 
> <0>[   67.455092] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> 
> <4>[   67.460385] Modules linked in:
> 
> <4>[   67.463424] CPU: 1    Not tainted
> (3.4.0-perf-g45c04fe-00006-g8a5c5e2 #27)

Can you try a newer kernel version?  Like 3.7-rc5?  3.6.6?

thanks,

greg k-h
