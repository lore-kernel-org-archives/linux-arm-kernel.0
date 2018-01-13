From: bp@alien8.de (Borislav Petkov)
Date: Sat, 13 Jan 2018 12:31:56 +0100
Subject: EDAC driver for ARMv8 L1/L2 cache
In-Reply-To: <VI1PR04MB2078FCB86150A2AABFE7AB439A170@VI1PR04MB2078.eurprd04.prod.outlook.com>
References: <20180109214332.ejiak6f35tnhbpke@pd.tnic>
 <VI1PR04MB20788AC2E71A3CFFC37B85BB9A100@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <bc8d7450-3f58-95c2-42c2-d16b2f7a76e4@linux.intel.com>
 <VI1PR04MB20786CC3E2981C0F60E095079A170@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180112171251.4ricaz3lzditr7pi@pd.tnic>
 <VI1PR04MB2078B4491702765BA546C5539A170@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180112173802.kb32zrxc5uhsjlxk@lakrids.cambridge.arm.com>
 <VI1PR04MB20780EF853A0822A6EFCFE449A170@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180112180048.srniseo2ft7ytqve@lakrids.cambridge.arm.com>
 <VI1PR04MB2078FCB86150A2AABFE7AB439A170@VI1PR04MB2078.eurprd04.prod.outlook.com>
Message-ID: <20180113113156.nnmkuh25rilzwf4p@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Btw,

I jus received a driver for this:

https://lkml.kernel.org/r/1515804626-21254-1-git-send-email-kyan at codeaurora.org

and I think you guys should first talk and do one version which works
for all.

Adding Kyle to CC.

@Kyle: there's also a driver here: https://patchwork.kernel.org/patch/7513231

Also, looking at it, you probably should call it arm64_edac or so, to
be clear what it is. armv8 - although known to ARM people - makes me go
look at wikipedia to refresh what v8 was again.

Also, I'd like you to figure out who's going to be maintaining it so
that get_maintainer.pl can find you on bug reports.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
