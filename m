From: scottwood@freescale.com (Scott Wood)
Date: Thu, 25 Sep 2014 17:56:20 -0500
Subject: [PATCHv4] clk: ppc-corenet: rename to ppc-qoriq and add
 CLK_OF_DECLARE support
In-Reply-To: <20140925225406.19023.25065@quantum>
References: <1411454806-8214-1-git-send-email-jingchang.lu@freescale.com>
 <d4a375f40b544cf1ae78ac82dc20569c@BL2PR03MB467.namprd03.prod.outlook.com>
 <1411675680.13320.201.camel@snotra.buserror.net>
 <20140925225406.19023.25065@quantum>
Message-ID: <1411685780.13320.209.camel@snotra.buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-09-25 at 15:54 -0700, Mike Turquette wrote:
> Quoting Scott Wood (2014-09-25 13:08:00)
> > Well, like I said, I'd rather see the CLK_OF_DECLARE stuff be made to
> > work on PPC rather than have the driver carry around two binding
> > methods.
> 
> I guess that is an existing problem, and not related directly to this
> patch? This patch is essentially just renames (though the V1.0/V2.0
> stuff seems weird).

This patch is adding CLK_OF_DECLARE.

-Scott
