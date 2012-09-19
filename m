From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 19 Sep 2012 12:13:14 +0200
Subject: [PATCH v2 1/5] mmc: host: sdhci-s3c: Add broken-voltage DT
 property for broken voltage quirk
In-Reply-To: <m38vc6k1qu.fsf@pullcord.laptop.org>
References: <1346748609-11115-1-git-send-email-t.figa@samsung.com>
 <1346748609-11115-2-git-send-email-t.figa@samsung.com>
 <m38vc6k1qu.fsf@pullcord.laptop.org>
Message-ID: <1587150.uFGRdL0s8e@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On Wednesday 19 of September 2012 01:42:01 Chris Ball wrote:
> On Tue, Sep 04 2012, Tomasz Figa wrote:
> > Some boards use fixed voltage regulator for vmmc supply (e.g. for eMMC
> > memories). MMC_CAP2_BROKEN_VOLTAGE must be enabled for them to operate
> > correctly.
>>
> Is there a reason we can't make this a property on the regulator instead?

Is there a reason we can't make this a property of the mmc subsystem? ;)

Now, seriously, could you elaborate on this a bit more? Do you mean that a 
regulator should provide a dummy set voltage operation that would accept 
any voltage?

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
