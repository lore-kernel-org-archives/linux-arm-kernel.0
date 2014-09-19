From: joshc@codeaurora.org (Josh Cartwright)
Date: Fri, 19 Sep 2014 11:29:17 -0500
Subject: [PATCH 3/3] watchdog: qcom: register a restart notifier
In-Reply-To: <541BAB06.7040502@roeck-us.net>
References: <cover.1411078425.git.joshc@codeaurora.org>
 <d0f4cd93ad3f6690d637413b1171ac3c71aba861.1411078426.git.joshc@codeaurora.org>
 <541B995A.6000609@roeck-us.net>
 <20140919033202.GF3749@joshc.qualcomm.com>
 <541BAB06.7040502@roeck-us.net>
Message-ID: <20140919162917.GJ3749@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 18, 2014 at 09:03:18PM -0700, Guenter Roeck wrote:
> On 09/18/2014 08:32 PM, Josh Cartwright wrote:
> >On Thu, Sep 18, 2014 at 07:47:54PM -0700, Guenter Roeck wrote:
> >>On 09/18/2014 03:27 PM, Josh Cartwright wrote:
[..]
> >
> >Nothing magic, it's just a reasonably low value to set the bite time
> >counter at.  It also happens to be the value at reset.
> >
> Can you add a note explaining that this reflects a reset delay of <n>
> milliseconds or whatever it is ?

Certainly.  Will do.

Thanks,
  Josh

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
