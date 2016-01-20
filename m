From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Wed, 20 Jan 2016 18:05:58 +0100
Subject: [RFC PATCH v3] irqchip: Add support for Tango interrupt controller
In-Reply-To: <20160120170219.GC28169@leverpostej>
References: <569CE0F2.1060507@sigmadesigns.com>
 <569D0B80.1010908@sigmadesigns.com> <569D165E.4060004@sigmadesigns.com>
 <569FAFF5.4090909@arm.com> <yw1xr3hcqlix.fsf@unicorn.mansr.com>
 <569FB4AE.8000506@sigmadesigns.com> <20160120170219.GC28169@leverpostej>
Message-ID: <569FBE76.10609@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/01/2016 18:02, Mark Rutland wrote:

> When you put together the binding document, please point out that the
> ranges property is necessary.

I don't quite understand.

Can I write the node without a ranges property, and the driver would
still function correctly?

Regards.
