From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 27 Mar 2013 18:12:22 +0100 (CET)
Subject: [PATCH v4] clk: allow reentrant calls into the clk framework
In-Reply-To: <20130327150634.4014.64797@quantum>
References: <1364368183-24420-1-git-send-email-mturquette@linaro.org>
 <1824016.8AdaQMMrrR@avalon> <20130327150634.4014.64797@quantum>
Message-ID: <alpine.LFD.2.02.1303271811020.22263@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Mar 2013, Mike Turquette wrote:
> Quoting Laurent Pinchart (2013-03-27 02:08:15)
> > I wonder if it would make sense to abstract these operations in a generic 
> > recursive mutex. Given that it would delay this patch past v3.10 I won't push 
> > for that.
> > 
> 
> Having a nice implementation of recursive mutexes would have saved me
> some time.

If you encapsulate stuff nicely like I suggested, then switching to a
generic version later on is a nobrainer.
 
Thanks,

	tglx
