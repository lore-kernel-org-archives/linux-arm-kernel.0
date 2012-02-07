From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 07 Feb 2012 15:30:26 +0200
Subject: [PATCH v2 7/7] MFD: TWL6040: Add regulator support for VIO, V2V1
 supplies
In-Reply-To: <20120207131657.GL3332@opensource.wolfsonmicro.com>
References: <1328619678-26080-1-git-send-email-peter.ujfalusi@ti.com>
 <1328619678-26080-8-git-send-email-peter.ujfalusi@ti.com>
 <20120207131657.GL3332@opensource.wolfsonmicro.com>
Message-ID: <4F312772.6090000@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/2012 03:16 PM, Mark Brown wrote:
> though I'd be inclined to just embed this structure into the twl6040
> struct directly, you're always going to need to allocate it and it saves
> a tiny bit of error handling and whatnot.

True. I'm not sure why I have settled with this solution... As I recall
I just did not wanted to add the regulator related includes to the
mfd/twl6040.h header.

-- 
P?ter
