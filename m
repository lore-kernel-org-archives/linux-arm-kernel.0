From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 4 Jan 2013 17:05:50 +0100
Subject: dma: mv_xor: error handling fixes
In-Reply-To: <1355404843-4587-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1355404843-4587-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130104170550.70a5b3e8@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason, Andrew, Gr?gory,

On Thu, 13 Dec 2012 14:20:41 +0100, Thomas Petazzoni wrote:
> Jason, Andrew, Gr?gory,
> 
> Here are two patches fixing error handling code in the mv_xor
> initialization code. When the initialization of one particular XOR
> channel fails, we have some cleanup code that isn't correct, and
> triggers a kernel warning (fixed by the first patch) and then a kernel
> crash (fixed by the second patch).
> 
> The original bug has been introduced in the big XOR series pushed for
> 3.8, so ideally, those patches should be pushed for 3.8 as well (but
> they can wait after 3.8-rc1 if needed).

Any issue with those patches? Any reason for them not being pushed for
3.8-rc?

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
