From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 07 Feb 2012 15:52:00 +0200
Subject: [PATCH v2 2/7] MFD: twl6040: Convert to i2c driver, and separate
 it from twl core
In-Reply-To: <20120207134344.GP3332@opensource.wolfsonmicro.com>
References: <1328619678-26080-1-git-send-email-peter.ujfalusi@ti.com>
 <1328619678-26080-3-git-send-email-peter.ujfalusi@ti.com>
 <20120207132925.GN3332@opensource.wolfsonmicro.com> <4F31298C.5090008@ti.com>
 <20120207134344.GP3332@opensource.wolfsonmicro.com>
Message-ID: <4F312C80.2020108@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/2012 03:43 PM, Mark Brown wrote:
> That just sounds far too icky - I'm really not happy that people have
> been doing that in ASoC TBH, it just makes everything more tricky than
> it should be.  It save a little bit of effort with the control but just
> pushes that complexity elsewhere where you're not expecting it.

Fair enough. I'll find a way to do this properly.

Thanks,
P?ter
