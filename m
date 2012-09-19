From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 19 Sep 2012 12:49:50 +0200
Subject: [PATCH v2 1/5] mmc: host: sdhci-s3c: Add broken-voltage DT
 property for broken voltage quirk
In-Reply-To: <m3627aguhl.fsf@pullcord.laptop.org>
References: <1346748609-11115-1-git-send-email-t.figa@samsung.com>
 <1907099.4JSZthrgh2@amdc1227> <m3627aguhl.fsf@pullcord.laptop.org>
Message-ID: <2908357.YMzdc5AO51@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

On Wednesday 19 of September 2012 06:47:02 Chris Ball wrote:
> Hi,
> 
> On Wed, Sep 19 2012, Tomasz Figa wrote:
> > We could just check if the regulator provides the capability to change
> > the voltage.
> > 
> > I don't see any direct way of querying the regulator for provided
> > capabilities (correct me if I'm just blind), but calling
> > regulator_count_voltages() on the regulator and checking if the
> > returned
> > value is 1 should be enough to assume that the regulator is fixed.
> 
> Sounds good, I agree.  Are you able to test that the obvious patch below
> works on your fixed-regulator board?

Yes. I will report the result as soon as I test it.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
