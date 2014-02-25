From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 25 Feb 2014 14:37:17 +0100
Subject: [PATCH v5 04/10] V4L: Add driver for s5k6a3 image sensor
In-Reply-To: <20140225095515.GV4869@tarshish>
References: <1393263322-28215-1-git-send-email-s.nawrocki@samsung.com>
 <1393263322-28215-5-git-send-email-s.nawrocki@samsung.com>
 <20140224193838.GL4869@tarshish> <530C6692.6090307@samsung.com>
 <20140225095515.GV4869@tarshish>
Message-ID: <530C9C8D.2040800@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/02/14 10:55, Baruch Siach wrote:
> Thanks for the explanation. However, I've found no reference to the 
> s5k6a3_sd_internal_ops struct in the driver code. There surly has to be at 
> least one reference for the upper layer to access these ops.

There is indeed an assignment missing to sd->internal_ops in probe().
Thanks for spotting this, I've corrected that for next iteration.

--
Regards,
Sylwester
