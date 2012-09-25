From: jonathan.austin@arm.com (Jonathan Austin)
Date: Tue, 25 Sep 2012 15:47:26 +0100
Subject: [PATCH v6 0/3] Updated Cortex-M3 series
In-Reply-To: <20120921190002.GU5525@pengutronix.de>
References: <1343988614-5508-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20120816202932.GY2232@pengutronix.de> <20120921190002.GU5525@pengutronix.de>
Message-ID: <5061C3FE.7050400@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On 21/09/12 20:00, Uwe Kleine-K?nig wrote:

> Hello,
> 
> On Thu, Aug 16, 2012 at 10:29:32PM +0200, Uwe Kleine-K?nig wrote:
>> On Fri, Aug 03, 2012 at 12:10:11PM +0200, Uwe Kleine-K?nig wrote:
>>> the only changes compared to v5 (sent starting with Message-id:
>>> 1341512035-8173-1-git-send-email-u.kleine-koenig at pengutronix.de)
>>> are that several debug pr_infos were dropped that I missed to remove
>>> before. Thanks to Will Deacon for pointing out that problem.
>>> Furthermore I rebased (trivially) to v3.5.
>> Any feedback from your side? It would be great to get this in for 3.7
>> with some time in next before.
> What must happen to get some feed back? Is it worth to assert the stuff
> still works with 3.6-rc6?

I hope to have a chance to look at these towards the end of the week...

Looking at the patch series at a very superficial level, I wonder why
you've chosen not to include any Kconfig/NVIC support at this stage,
especially as you've posted some before and there appears to be
something (presumably) working in your efm32 branch...

It would be a shame to spend time on merging the basic support if there
are issues that mean the interrupt support won't follow.

Jonny
