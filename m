From: ian.campbell@citrix.com (Ian Campbell)
Date: Wed, 22 Jul 2015 10:47:18 +0100
Subject: [PATCH] dtb: Create a common home for cross-architecture dtsi
 files.
In-Reply-To: <20150722084753.GC14923@e106497-lin.cambridge.arm.com>
References: <1437496204-5438-1-git-send-email-ian.campbell@citrix.com>
 <20150722084753.GC14923@e106497-lin.cambridge.arm.com>
Message-ID: <1437558438.8383.72.camel@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-07-22 at 09:47 +0100, Liviu Dudau wrote:
> 
> Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>

Thanks.

> Picking your brains here: would it be worth to have some vendor directories in
> this shared area or we can hope that there will be very few files living here?

I'm honestly not sure.

I don't expect there will be very many files under here, and I would
expect the norm would be that common .dtsi files used by multiple
arches would be things from the same vendor, but I don't think we can
guarantee that.

Ian.
