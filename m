From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 17 Nov 2016 15:52:29 +0530
Subject: [PATCH 0/8] DMA: s3c64xx: Conversion to the new channel request
 API
In-Reply-To: <2b33d23d-b7c5-6e6d-454f-755c86ddd5eb@samsung.com>
References: <1478791076-19528-1-git-send-email-s.nawrocki@samsung.com>
 <20161116032620.GV3000@localhost>
 <CGME20161116170345epcas4p4615ed113ee5031ad4b6778996d69fb20@epcas4p4.samsung.com>
 <20161116170337.GA4124@kozik-lap>
 <2b33d23d-b7c5-6e6d-454f-755c86ddd5eb@samsung.com>
Message-ID: <20161117102228.GD2698@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2016 at 06:31:13PM +0100, Sylwester Nawrocki wrote:
> On 11/16/2016 06:03 PM, Krzysztof Kozlowski wrote:
> > As I understood, everything won't be applied because ASoC tree already
> > contains some work around this?
> 
> Yes, sorry, I didn't coordinate this work very well, there are some patches
> for the pcm and the i2s driver already in the ASoC tree which would conflict
> with this series. I'd suggest to ignore patches 5/8...8/8 for now.

Okay, applied 1 thru 4 now after fixing subsystem name on 1st.

Anyone wants to pull can fetch topic/s3c64xx

Thanks
-- 
~Vinod
