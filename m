From: bp@alien8.de (Borislav Petkov)
Date: Tue, 9 Jan 2018 22:43:32 +0100
Subject: EDAC driver for ARMv8 L1/L2 cache
In-Reply-To: <VI1PR04MB2078DBC9381EA574CE5DA4B09A100@VI1PR04MB2078.eurprd04.prod.outlook.com>
References: <VI1PR04MB2078DBC9381EA574CE5DA4B09A100@VI1PR04MB2078.eurprd04.prod.outlook.com>
Message-ID: <20180109214332.ejiak6f35tnhbpke@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding some more people to CC.

On Tue, Jan 09, 2018 at 08:48:43PM +0000, York Sun wrote:
> Borislav,
> 
> Are you aware of any existing (or in development) EDAC driver for ARMv8
> L1/L2 cache? I am thinking to write one if not available yet.

no I'm not but I see two EDAC drivers for ARM64: thunderx and xgene.

Please synchronize with their authors and ARM people what would be the
best thing to do and try extracting shared functionality from them
into a common compilation unit instead of duplicating it. I don't want
separate drivers per functional unit.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
