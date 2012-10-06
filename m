From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 6 Oct 2012 16:26:40 +0800
Subject: [PATCH v2 27/34] media: mx2_camera: remove cpu_is_xxx by using
 platform_device_id
In-Reply-To: <20120927160321.56420910@redhat.com>
References: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
 <1348123547-31082-28-git-send-email-shawn.guo@linaro.org>
 <20120927160321.56420910@redhat.com>
Message-ID: <20121006082638.GB20231@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2012 at 04:03:21PM -0300, Mauro Carvalho Chehab wrote:
> It seems that it depends on some stuff that got merged via the arm tree.
> 
> Not sure what would the better way to handle that, as applying it via -arm
> will likely generate conflicts when merging from both trees upstream.
> 
> If this change is not urgent, maybe it would be better to apply it after
> the end of the merge window, via either one of the trees.
> 
That's the original plan, having it merged via arm-soc tree at the end
of 3.7 merge window.  But I was told by arm-soc folks that we already
have enough conflicts to sort out for this window, and we do not want
any more.  And we have to postpone it to 3.8.

I will publish a topic branch for this series after 3.7-rc1 comes out.

Shawn
