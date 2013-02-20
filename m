From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 20 Feb 2013 16:38:56 +0000
Subject: [PATCH 02/35] mfd: ab8500-gpadc: Allow tvout regulator to be
 missing
In-Reply-To: <20130220132321.GC13049@sirena.org.uk>
References: <1360933026-30325-1-git-send-email-lee.jones@linaro.org>
 <1360933026-30325-3-git-send-email-lee.jones@linaro.org>
 <20130220132321.GC13049@sirena.org.uk>
Message-ID: <20130220163856.GC4417@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Feb 2013, Mark Brown wrote:

> On Fri, Feb 15, 2013 at 12:56:33PM +0000, Lee Jones wrote:
> 
> > +	if (gpadc->regu)
> > +		regulator_disable(gpadc->regu);
> 
> No explanation for this in the changelog and missing error handling like
> this is pretty much always terrible style.  Why are we doing this?

No idea, and Jonas is on parental leave.

Perhaps one of the other guys have an explanation?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
