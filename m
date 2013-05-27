From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 27 May 2013 13:57:37 +0800
Subject: [PATCH v3] tty: serial: add Freescale lpuart driver support
In-Reply-To: <13F8657A829DAB49A2A937FD6FC10F790B3D5056@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1368685096-13177-1-git-send-email-b35083@freescale.com>
 <20130520030523.GB25113@S2101-09.ap.freescale.net>
 <13F8657A829DAB49A2A937FD6FC10F790B3CDB85@039-SN2MPN1-012.039d.mgd.msft.net>
 <CAAQ0ZWRz+byPKxMjDH3zKsc0u4bmkPO_1u6w2H4Z7nD0z8+9ig@mail.gmail.com>
 <13F8657A829DAB49A2A937FD6FC10F790B3CECEB@039-SN2MPN1-012.039d.mgd.msft.net>
 <20130523025059.GB2704@S2101-09.ap.freescale.net>
 <13F8657A829DAB49A2A937FD6FC10F790B3D5056@039-SN2MPN1-012.039d.mgd.msft.net>
Message-ID: <20130527055734.GD7782@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 27, 2013 at 01:27:04AM +0000, Jin Zhengxiong-R64188 wrote:
> By the way, we'll change the SoC name from mvf600 to vf610 to align the description in the document. 
> 

Such product renaming in documents happen on IMX as well, but we do
not bother to churn the source tree (file, function renaming) to catch
up with it, as long as we know what it is.

For this mvf600 to vf610 renaming, if you want to catch up with it, you
will need to rename a bunch of files functions, compatibles in Jingchang's
series, and it's probably fine even though it's not really necessary
since they haven't been merged.  But for those which have been merged,
like fec compatible string, doing this will probably piss off
maintainers.  So I would suggest that we stick to name mvf600 in the
source tree, and just be aware of it's the equivalent of vf610.

Shawn
