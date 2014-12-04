From: Andrew.Jackson@arm.com (Andrew Jackson)
Date: Thu, 04 Dec 2014 09:05:01 +0000
Subject: [PATCH 1/5] ASoC: dwc: Allocate resources with
 devm_ioremap_resource
In-Reply-To: <20141203182659.GG7712@sirena.org.uk>
References: <547F3C96.9070509@arm.com> <20141203182659.GG7712@sirena.org.uk>
Message-ID: <548023BD.8020804@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/14 18:26, Mark Brown wrote:
> On Wed, Dec 03, 2014 at 04:38:46PM +0000, Andrew Jackson wrote:
>> Prepare for the introduction of device-tree support by re-ordering some
>> of the allocations and using devm_iomap_resource to simplify IO mapping.
> 
> Applied, thanks.
> 

Lars-Peter Clausen had some comments on this patch so I was intending to resubmit it.  Would you prefer that I submit a patch to my original?

  Andrew
