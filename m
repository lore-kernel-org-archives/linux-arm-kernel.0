From: johnstul@us.ibm.com (john stultz)
Date: Thu, 19 May 2011 18:10:53 -0700
Subject: [patch 2/7] clocksource: Get rid of the hardcoded 5 seconds
	sleep time limit
In-Reply-To: <1305766655.2915.187.camel@work-vm>
References: <20110518205713.947614271@linutronix.de>
	<20110518210136.109811585@linutronix.de>
	<1305766655.2915.187.camel@work-vm>
Message-ID: <1305853853.2915.214.camel@work-vm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-05-18 at 17:57 -0700, John Stultz wrote:
> Overall it looks good. I'm doing some NTP testing with the TSC shift
> change to make sure we don't get any odd side effects. I'll let you know
> how those go.

So from overnight testing all looks well.

thanks
-john
