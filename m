From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri, 27 Mar 2015 14:29:35 +0100
Subject: exynos5800-peach-pi: suspend/resume (still) broken
In-Reply-To: <CAM4voanUg87=Ya6azGCRz8r2=WJ0wi4ktqdn6GD6ULJsnLUMmw@mail.gmail.com>
References: <CAMAWPa_r04tAXAXosmLk+DfwvQV0qpD+=8O7T_pwFTAozcjOgQ@mail.gmail.com>	<550953ED.10508@collabora.co.uk>	<CAM4voakvhHuVXLY2DmdGexfrqSYUqhXhg1krLwO4CCxjHQ1NCw@mail.gmail.com>	<550C47ED.3010301@collabora.co.uk>	<CAM4voamLt=6dSY-DwDb+c=KRwDWAvjvzUUnno+=+1svDqf41Qg@mail.gmail.com>
 <CAM4voanUg87=Ya6azGCRz8r2=WJ0wi4ktqdn6GD6ULJsnLUMmw@mail.gmail.com>
Message-ID: <55155B3F.2010704@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Abhilash,

On 03/20/2015 06:40 PM, Abhilash Kesavan wrote:
> 
> Regarding the mdma0 disablement, it looks like for the system to
> suspend properly the mdma0 pclk needs to stay on.
> 

I had time today again to work on this issue and the best
place I found to enable and disable the mdma0 clock is in
exynos5420_pm_{prepare,resume}. Please let me know if you
have a better idea of where the clock should be managed.

I'll send a RFC patch-set soon.

> Regards,
> Abhilash

Best regards,
Javier
