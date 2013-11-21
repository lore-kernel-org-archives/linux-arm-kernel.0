From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Thu, 21 Nov 2013 11:13:57 +0200
Subject: [PATCH 11/31] dma: add channel request API that supports
 deferred probe
In-Reply-To: <CAPcyv4jRYu7iTOuiXuj9F-t5dpF3ErVHT4X-PKrkJAYfn91a0w@mail.gmail.com>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-12-git-send-email-swarren@wwwdotorg.org>
 <CAPcyv4heN3PFc+n2RDBviA0zvyU4jfi5VLOcQVR6oRPi1woPTA@mail.gmail.com>
 <1384766276.14845.155.camel@smile> <528A5170.3090809@wwwdotorg.org>
 <1384862421.14845.222.camel@smile> <528B9CAE.3040600@wwwdotorg.org>
 <CAPcyv4jR2MufF6PqB3cUwNdQZfzGWVdj1UunBkeyMYm-KvkpCQ@mail.gmail.com>
 <528BFDD0.3090503@wwwdotorg.org>
 <CAPcyv4i7o0RP4ovG1S8RbiV9wqV+VZWX+2vBm3iKnVLCYfrnBQ@mail.gmail.com>
 <528CFE68.6060908@wwwdotorg.org>
 <CAPcyv4hjJDOq+qEvuCG32PLQcWeHVyeVDCy=5UM8KX445OxY_w@mail.gmail.com>
 <528D0C06.9080006@wwwdotorg.org>
 <1384979000.2067.5.camel@dwillia2-mobl1.amr.corp.intel.com>
 <528D28A1.2050307@wwwdotorg.org>
 <CAPcyv4jRYu7iTOuiXuj9F-t5dpF3ErVHT4X-PKrkJAYfn91a0w@mail.gmail.com>
Message-ID: <1385025237.6723.28.camel@smile>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-11-20 at 19:22 -0800, Dan Williams wrote:
> On Wed, Nov 20, 2013 at 1:24 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

[]

> I'm proposing that clients explicitly handle an updated
> dma_request_slave_channel and we skip this interim
> dma_request_slave_channel_no_err step.

Actually this makes more sense.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
