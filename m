From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Tue, 19 Nov 2013 14:00:21 +0200
Subject: [PATCH 11/31] dma: add channel request API that supports
 deferred probe
In-Reply-To: <528A5170.3090809@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-12-git-send-email-swarren@wwwdotorg.org>
 <CAPcyv4heN3PFc+n2RDBviA0zvyU4jfi5VLOcQVR6oRPi1woPTA@mail.gmail.com>
 <1384766276.14845.155.camel@smile> <528A5170.3090809@wwwdotorg.org>
Message-ID: <1384862421.14845.222.camel@smile>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-11-18 at 10:42 -0700, Stephen Warren wrote:
> On 11/18/2013 02:18 AM, Shevchenko, Andriy wrote:
> > On Fri, 2013-11-15 at 13:01 -0800, Dan Williams wrote:
> >> On Fri, Nov 15, 2013 at 12:54 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> > 
> >>> Eventually, all drivers should be converted to this new API, the old API
> >>> removed, and the new API renamed to the more desirable name. 
> > 
> > I really would like to see more sensible and shorter names for the API
> > functions.
> 
> I'm not sure if you're suggesting that you:
> 
> a) Really want to API renaming I mention above to happen at some time.
> 
> b) We need to pick a better name now, for the new API this patch
> introduces. If so, do you have any better suggestion?

Sooner better, I think. 

Now only what I can propose is to change
dma_slave_request_channel_or_err() to dma_slave_request_chan().

In any way the dma_slave_request_* API is quite new and we, as far as I
understood, will come when the main request function will always return
channel or error.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
