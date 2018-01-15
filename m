From: bp@alien8.de (Borislav Petkov)
Date: Mon, 15 Jan 2018 15:32:49 +0100
Subject: EDAC driver for ARMv8 L1/L2 cache
In-Reply-To: <20180115142154.rj6cgnhlll7ivyew@lakrids.cambridge.arm.com>
References: <bc8d7450-3f58-95c2-42c2-d16b2f7a76e4@linux.intel.com>
 <VI1PR04MB20786CC3E2981C0F60E095079A170@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180112171251.4ricaz3lzditr7pi@pd.tnic>
 <VI1PR04MB2078B4491702765BA546C5539A170@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180112173802.kb32zrxc5uhsjlxk@lakrids.cambridge.arm.com>
 <VI1PR04MB20780EF853A0822A6EFCFE449A170@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180112180048.srniseo2ft7ytqve@lakrids.cambridge.arm.com>
 <VI1PR04MB2078FCB86150A2AABFE7AB439A170@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180113113156.nnmkuh25rilzwf4p@pd.tnic>
 <20180115142154.rj6cgnhlll7ivyew@lakrids.cambridge.arm.com>
Message-ID: <20180115143249.tod4rqzn3udk6wmu@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 15, 2018 at 02:21:54PM +0000, Mark Rutland wrote:
> I'm not sure it's possible to cover all potential EDAC implementations
> behind the same driver.
> 
> If we need these drivers, they should be <cpuname>_edac or <soc>_edac.

Yuck, I wanted to avoid that...

Oh well, can we at least share the barebones design and exchange
registers/DT only or is it more complicated than that?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
