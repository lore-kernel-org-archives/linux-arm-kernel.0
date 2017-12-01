From: richardcochran@gmail.com (Richard Cochran)
Date: Fri, 1 Dec 2017 07:56:05 -0800
Subject: [PATCH 1/1] timecounter: Make cyclecounter struct part of
 timecounter struct
In-Reply-To: <1512114454-26958-1-git-send-email-sagar.a.kamble@intel.com>
References: <1512114454-26958-1-git-send-email-sagar.a.kamble@intel.com>
Message-ID: <20171201155605.7c7oiq5we4n7wdum@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 01, 2017 at 01:17:34PM +0530, Sagar Arun Kamble wrote:
> There is no real need for the users of timecounters to define cyclecounter
> and timecounter variables separately. Since timecounter will always be
> based on cyclecounter, have cyclecounter struct as member of timecounter
> struct.

Could you please put the PTP maintainer onto CC?

Thanks,
Richard
