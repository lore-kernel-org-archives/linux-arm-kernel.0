From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 27 Mar 2013 18:09:16 +0100 (CET)
Subject: [PATCH v4] clk: allow reentrant calls into the clk framework
In-Reply-To: <20130327164716.4014.97638@quantum>
References: <1364368183-24420-1-git-send-email-mturquette@linaro.org>
 <alpine.LFD.2.02.1303271209490.22263@ionos>
 <20130327164716.4014.97638@quantum>
Message-ID: <alpine.LFD.2.02.1303271807040.22263@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Mar 2013, Mike Turquette wrote:
> Thanks for the review Thomas.  I will steal your code and call it my own
> in the next version.

Sure.

> In particular getting rid of the atomics makes things much nicer.

I'd say using the helper functions and not having all these
conditionals makes it really nice :)

Thanks,

	tglx
