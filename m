From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 25 Sep 2012 17:00:26 +0200
Subject: [PATCH v6 0/3] Updated Cortex-M3 series
In-Reply-To: <5061C3FE.7050400@arm.com>
References: <1343988614-5508-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20120816202932.GY2232@pengutronix.de>
 <20120921190002.GU5525@pengutronix.de> <5061C3FE.7050400@arm.com>
Message-ID: <20120925150026.GG21730@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Sep 25, 2012 at 03:47:26PM +0100, Jonathan Austin wrote:
> On 21/09/12 20:00, Uwe Kleine-K?nig wrote:
> > On Thu, Aug 16, 2012 at 10:29:32PM +0200, Uwe Kleine-K?nig wrote:
> >> On Fri, Aug 03, 2012 at 12:10:11PM +0200, Uwe Kleine-K?nig wrote:
> >>> the only changes compared to v5 (sent starting with Message-id:
> >>> 1341512035-8173-1-git-send-email-u.kleine-koenig at pengutronix.de)
> >>> are that several debug pr_infos were dropped that I missed to remove
> >>> before. Thanks to Will Deacon for pointing out that problem.
> >>> Furthermore I rebased (trivially) to v3.5.
> >> Any feedback from your side? It would be great to get this in for 3.7
> >> with some time in next before.
> > What must happen to get some feed back? Is it worth to assert the stuff
> > still works with 3.6-rc6?
> 
> I hope to have a chance to look at these towards the end of the week...
> 
> Looking at the patch series at a very superficial level, I wonder why
> you've chosen not to include any Kconfig/NVIC support at this stage,
> especially as you've posted some before and there appears to be
> something (presumably) working in your efm32 branch...
>
> It would be a shame to spend time on merging the basic support if there
> are issues that mean the interrupt support won't follow.
I plan to expand common/gic.c for interrupt support. Currently I don't
do much though because getting feedback and the changes into mainline is
quite hard and I don't want to spend time now and hear later that I did
it wrong or something. So I put my efforts on hold and only ping from
time to time.  :-(

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
