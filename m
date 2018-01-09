From: bp@alien8.de (Borislav Petkov)
Date: Tue, 9 Jan 2018 23:00:10 +0100
Subject: EDAC driver for ARMv8 L1/L2 cache
In-Reply-To: <VI1PR04MB20788AC2E71A3CFFC37B85BB9A100@VI1PR04MB2078.eurprd04.prod.outlook.com>
References: <VI1PR04MB2078DBC9381EA574CE5DA4B09A100@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180109214332.ejiak6f35tnhbpke@pd.tnic>
 <VI1PR04MB20788AC2E71A3CFFC37B85BB9A100@VI1PR04MB2078.eurprd04.prod.outlook.com>
Message-ID: <20180109220009.fgpp6n6c5r4hxihp@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 09, 2018 at 09:51:32PM +0000, York Sun wrote:
> On 01/09/2018 01:43 PM, Borislav Petkov wrote:
> > Adding some more people to CC.
> > 
> > On Tue, Jan 09, 2018 at 08:48:43PM +0000, York Sun wrote:
> >> Borislav,
> >>
> >> Are you aware of any existing (or in development) EDAC driver for ARMv8
> >> L1/L2 cache? I am thinking to write one if not available yet.
> > 
> > no I'm not but I see two EDAC drivers for ARM64: thunderx and xgene.
> > 
> > Please synchronize with their authors and ARM people what would be the
> > best thing to do and try extracting shared functionality from them
> > into a common compilation unit instead of duplicating it. I don't want
> > separate drivers per functional unit.
> > 
> 
> Thanks for the pointer. Thunderx and xgene's drivers have different
> implementation on the hardware. I found one patch closer to what I
> expect, https://patchwork.kernel.org/patch/7513231/. I don't see
> activities after 2015. I will reach out to the author.

He's probably busy with SME/SEV right now.

+ Marc.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
