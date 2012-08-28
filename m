From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 28 Aug 2012 08:28:30 +0800
Subject: [PATCH 4/4] ARM: mxs: Add SchulerControl SPS1 DTS file
In-Reply-To: <20120825083042.GM31998@S2101-09.ap.freescale.net>
References: <1345852300-2213-1-git-send-email-marex@denx.de>
 <1345852300-2213-4-git-send-email-marex@denx.de>
 <20120825083042.GM31998@S2101-09.ap.freescale.net>
Message-ID: <20120828002828.GI2281@r65073-Latitude-D630>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 25, 2012 at 04:30:45PM +0800, Shawn Guo wrote:
> > +				flash: m25p80 at 0 {
> > +					#address-cells = <1>;
> > +					#size-cells = <1>;
> > +					compatible = "everspin,mr25h256", "mr25h256";
> 
> Node name "m25p80" and "mr25h256", same thing?
> 
Ok, just got reminded by Fabio, m25p80 covers many devices including
mr25h256 here.

-- 
Regards,
Shawn
