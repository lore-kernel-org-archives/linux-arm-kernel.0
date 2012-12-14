From: richardcochran@gmail.com (Richard Cochran)
Date: Fri, 14 Dec 2012 08:13:00 +0100
Subject: cpts: Fix build error caused by include of plat/clock.h
In-Reply-To: <20121213213641.GF4989@atomide.com>
References: <20121213213641.GF4989@atomide.com>
Message-ID: <20121214071300.GA2253@netboy.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 13, 2012 at 01:36:41PM -0800, Tony Lindgren wrote:
> Commit 87c0e764 (cpts: introduce time stamping code and a PTP hardware clock)
> mistakenly included plat/clock.h that should not be included by drivers
> even if it exists.

Hasn't this already been fixed?

  https://patchwork.kernel.org/patch/1810481/
  http://www.spinics.net/lists/linux-omap/msg83132.html

Thanks,
Richard
