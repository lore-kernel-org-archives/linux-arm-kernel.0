From: irina.tirdea@intel.com (Tirdea, Irina)
Date: Mon, 18 Apr 2016 12:18:06 +0000
Subject: [PATCH v2 1/5] iio: accel: bmc150: use regmap to retrieve
 struct device
In-Reply-To: <57129064.9050508@kernel.org>
References: <cover.1460314070.git.amsfield22@gmail.com>
 <f3cae5dd803486a774248afad096032f3f0546a2.1460314070.git.amsfield22@gmail.com>
 <57129064.9050508@kernel.org>
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F260D21@irsmsx105.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23 at kernel.org]
> Sent: 16 April, 2016 22:20
> To: Alison Schofield
> Cc: knaack.h at gmx.de; lars at metafoo.de; pmeerw at pmeerw.net; kgene at kernel.org; k.kozlowski at samsung.com; linux-
> iio at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-samsung-soc at vger.kernel.org;
> Srinivas Pandruvada; Tirdea, Irina
> Subject: Re: [PATCH v2 1/5] iio: accel: bmc150: use regmap to retrieve struct device
> 
> On 10/04/16 20:05, Alison Schofield wrote:
> > Driver includes struct regmap and struct device in its global data.
> > Remove the struct device and use regmap API to retrieve device info.
> >
> > Patch created using Coccinelle plus manual edits.
> >
> > Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> I'm happy with this but please do make sure to cc the maintainer / author
> of drivers if possible (often the email addresses are out of date!)
> 
> Srinivas, this is one of yours.  Are you happy with this?
> I've also cc'd Irina who has worked on this driver recently for any
> comments.
> 

Looks good to me.
Reviewed-by: Irina Tirdea <irina.tirdea@intel.com>

Alison, I think bmc150_magn driver qualifies for this change as well
after Daniel's patches got merged [1].

Thanks,
Irina

[1] https://lkml.org/lkml/2016/4/15/407

> If no one comments in the meantime I'll probably pick these up sometime
> in the next week.
> 
> Jonathan
