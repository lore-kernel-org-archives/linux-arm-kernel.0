From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 19 Nov 2013 10:07:24 -0700
Subject: [PATCH V2] dma: add channel request API that supports deferred
 probe
In-Reply-To: <1384861763.14845.219.camel@smile>
References: <1384803581-23871-1-git-send-email-swarren@wwwdotorg.org>
 <1384861763.14845.219.camel@smile>
Message-ID: <528B9ACC.3060109@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19/2013 04:49 AM, Shevchenko, Andriy wrote:
> On Mon, 2013-11-18 at 12:39 -0700, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
> 
> Thanks for an updated version.
> Still couple of comments below.
> 
> After addressing them
> 
> Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> for the acpi-dma.c part.

Thanks. Sorry I missed the s/ENODEV/EINVAL/ in
acpi_dma_request_slave_chan_by_name(). I know having review comments
overlooked or ignored can be annoying. It's all fixed now:-)
