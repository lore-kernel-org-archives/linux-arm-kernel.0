From: tony@atomide.com (Tony Lindgren)
Date: Mon, 18 Oct 2010 16:11:47 -0700
Subject: [PATCHv2 1/1] omap: Ptr "isr_reg" tracked as NULL was dereferenced
In-Reply-To: <1287123378.12782.49.camel@ekuznets-lx-nokia>
References: <cover.1286961160.git.EXT-Eugeny.Kuznetsov@nokia.com>
	<7bb69801f49283c3bde78aa008c15308ac8a5fbf.1286961160.git.EXT-Eugeny.Kuznetsov@nokia.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030D099AFD@dbde02.ent.ti.com>
	<1286970199.12782.28.camel@ekuznets-lx-nokia>
	<EAF47CD23C76F840A9E7FCE10091EFAB030D099B87@dbde02.ent.ti.com>
	<1286971758.12782.35.camel@ekuznets-lx-nokia>
	<1287123378.12782.49.camel@ekuznets-lx-nokia>
Message-ID: <20101018231147.GK13341@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Evgeny Kuznetsov <EXT-Eugeny.Kuznetsov@nokia.com> [101014 23:11]:
> On Wed, 2010-10-13 at 16:09 +0400, Evgeny Kuznetsov wrote:
> > On Wed, 2010-10-13 at 17:20 +0530, ext Varadarajan, Charulatha wrote:
> Hi Tony,
> 
> It is not a bug fix, it is just check to prevent potential issues. Used
> to warn in case of bug and prevent kernel oops. Check added only here
> (not all gpio code cleanup) since here it could cause kernel opps.
> 
> Would you apply patch if I will leave only if condition section in
> patch?
> 
> 	if (WARN_ON(!isr_reg))
> 		goto exit;
> 
> If yes, I'll resend v3 patch.

Sounds like a valid check to me.

Tony
