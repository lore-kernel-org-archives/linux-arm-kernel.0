From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sun, 13 May 2018 10:45:40 +0200
Subject: [PATCH] cpufreq: s3c2440: fix spelling mistake: "divsiors" ->
 "divisors"
In-Reply-To: <20180502053721.5h6jhicjsjss2ixe@vireshk-i7>
References: <20180430144801.6727-1-colin.king@canonical.com>
 <20180502053721.5h6jhicjsjss2ixe@vireshk-i7>
Message-ID: <3819884.ugggRtP9TD@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, May 2, 2018 7:37:21 AM CEST Viresh Kumar wrote:
> On 30-04-18, 15:48, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Trivial fix to spelling mistake in s3c_freq_dbg debug message text.
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/cpufreq/s3c2440-cpufreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/s3c2440-cpufreq.c b/drivers/cpufreq/s3c2440-cpufreq.c
> > index d0d75b65ddd6..d2f67b7a20dd 100644
> > --- a/drivers/cpufreq/s3c2440-cpufreq.c
> > +++ b/drivers/cpufreq/s3c2440-cpufreq.c
> > @@ -143,7 +143,7 @@ static void s3c2440_cpufreq_setdivs(struct s3c_cpufreq_config *cfg)
> >  {
> >  	unsigned long clkdiv, camdiv;
> >  
> > -	s3c_freq_dbg("%s: divsiors: h=%d, p=%d\n", __func__,
> > +	s3c_freq_dbg("%s: divisors: h=%d, p=%d\n", __func__,
> >  		     cfg->divs.h_divisor, cfg->divs.p_divisor);
> >  
> >  	clkdiv = __raw_readl(S3C2410_CLKDIVN);
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> 

Applied, thanks!
