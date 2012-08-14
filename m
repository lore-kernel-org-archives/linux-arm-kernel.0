From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 14 Aug 2012 09:14:50 +0300
Subject: [PATCH v2 1/9] ARM/ASoC: omap-mcbsp: Move OMAP2+ clock parenting
 code to ASoC driver
In-Reply-To: <20120813153554.GA31662@n2100.arm.linux.org.uk>
References: <1344867768-26335-1-git-send-email-peter.ujfalusi@ti.com>
 <1344867768-26335-2-git-send-email-peter.ujfalusi@ti.com>
 <20120813153554.GA31662@n2100.arm.linux.org.uk>
Message-ID: <5029ECDA.5020405@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/13/2012 06:35 PM, Russell King - ARM Linux wrote:
> I know the same error is in the original code, but let's stop propagating
> it.  IS_ERR() only here please.

I have overlooked this. I'll include the fix in v3.

-- 
P?ter
