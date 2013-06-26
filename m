From: trini@ti.com (Tom Rini)
Date: Wed, 26 Jun 2013 13:45:33 -0400
Subject: OMAP baseline test results for v3.10-rc6
In-Reply-To: <alpine.DEB.2.02.1306261726280.6135@utopia.booyaka.com>
References: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com>
 <20130625160243.GE22312@arwen.pp.htv.fi>
 <alpine.DEB.2.02.1306251746060.14373@utopia.booyaka.com>
 <51C9F0A8.1050607@ti.com> <87fvw6t136.fsf@linaro.org>
 <79CD15C6BA57404B839C016229A409A83ECC952D@DBDE04.ent.ti.com>
 <51CAEB33.5010101@ti.com> <51CAEBF3.1010507@ti.com>
 <alpine.DEB.2.02.1306261726280.6135@utopia.booyaka.com>
Message-ID: <51CB28BD.2020105@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/26/2013 01:28 PM, Paul Walmsley wrote:
> On Wed, 26 Jun 2013, Tom Rini wrote:
> 
>> Yes, please confirm that they're being set.
> 
> For the Kconfig that I use to boot the BeagleBone-white, which is called 
> "am33xx_only", yes, both of those are set.  
> 
> Here's the v3.8-rc1 version of this Kconfig as an example:
> 
> http://www.pwsan.com/omap/testlogs/test_v3.8-rc1/20121228031713/build/am33xx_only/am33xx_only

OK, is there a reason to not be using omap2plus_defconfig?  My pass/fail
here is based on that config and enabling, or not, dtb append.  Seems
like it would be one less thing to maintain on your end and it would be
on TIs end (roughly speaking) to make sure our platforms that ought to
be working upstream have what they need enabled in the defconfig(s) in
question.

-- 
Tom
