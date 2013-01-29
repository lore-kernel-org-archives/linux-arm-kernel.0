From: richardcochran@gmail.com (Richard Cochran)
Date: Tue, 29 Jan 2013 08:26:56 +0100
Subject: [RFC PATCH 0/4] Add support for LZ4-compressed kernels
In-Reply-To: <20130128142510.68092e10.akpm@linux-foundation.org>
References: <1359179447-31118-1-git-send-email-kyungsik.lee@lge.com>
 <20130128142510.68092e10.akpm@linux-foundation.org>
Message-ID: <20130129072656.GA18272@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 02:25:10PM -0800, Andrew Morton wrote:
> 
> It's a lot of code for a 50ms boot-time improvement.  Does anyone have
> any opinions on whether or not the benefits are worth the cost?

In the embedded space, quick boot is a really important feature to
have. Many people resort to awful hacks in order to improve boot time,
and so I would welcome this option.

I have seen arm systems that boot in 300 ms. I would say that 50 ms is
maybe not such a small improvement after all.

Thanks,
Richard
