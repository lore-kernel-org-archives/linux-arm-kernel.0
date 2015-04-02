From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 3 Apr 2015 00:04:11 +0200
Subject: [PATCH 2/6] selftest/kdbus: enable cross compilation
In-Reply-To: <551D7C37.8030701@osg.samsung.com>
References: <1427930420-4762-1-git-send-email-tyler.baker@linaro.org>
 <1427930420-4762-3-git-send-email-tyler.baker@linaro.org>
 <551D7C37.8030701@osg.samsung.com>
Message-ID: <20150402220411.GC3942@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 02, 2015 at 11:28:23AM -0600, Shuah Khan wrote:
> On 04/01/2015 05:20 PM, Tyler Baker wrote:
> > Use the CC variable instead of hard coding gcc and include lib.mk.
> > 
> > Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
> 
> Greg,
> 
> Will you be able to take this patch in with the other
> kdbus sleftest patches?
> 
> Acked-by: Shuah Khan <shuahkh@osg.samsung.com>

Thanks, I'll pick this up through my tree.

greg k-h
