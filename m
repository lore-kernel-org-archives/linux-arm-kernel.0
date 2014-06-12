From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 12 Jun 2014 09:46:19 +0100
Subject: [PATCH v4 3/6] drivers: cpuidle: implement OF based idle states
 infrastructure
In-Reply-To: <alpine.LFD.2.11.1406111420450.25775@knanqh.ubzr>
References: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1402503520-8611-4-git-send-email-lorenzo.pieralisi@arm.com>
 <alpine.LFD.2.11.1406111420450.25775@knanqh.ubzr>
Message-ID: <20140612084619.GA29295@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 11, 2014 at 07:24:12PM +0100, Nicolas Pitre wrote:
> On Wed, 11 Jun 2014, Lorenzo Pieralisi wrote:
> 
> > +config OF_IDLE_STATES
> > +        bool "Idle states DT support"
> > +	depends on ARM || ARM64
> > +	default n
> 
> The default for default is n already, so you don't have to default to 
> the default's default.

Ok, thanks for spotting that.

Lorenzo
