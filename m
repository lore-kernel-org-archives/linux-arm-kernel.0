From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Thu, 27 May 2010 15:14:17 +0100
Subject: [alsa-devel] [PATCH v2 2/4] soc/imx: add eukrea-tlv320
In-Reply-To: <4BFE7BFF.7010400@eukrea.com>
References: <1274950737-26498-1-git-send-email-eric@eukrea.com>
	<1274950737-26498-2-git-send-email-eric@eukrea.com>
	<1274968205.3542.283.camel@odin>  <4BFE7BFF.7010400@eukrea.com>
Message-ID: <1274969657.3542.303.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-05-27 at 16:04 +0200, Eric B?nard wrote:
> Hi Liam,
> 
> Le 27/05/2010 15:50, Liam Girdwood a ?crit :
> >> +
> >> +	eukrea_tlv320_dai.cpu_dai =&imx_ssi_pcm_dai[0];
> >
> > Any reason why this is not defined above ?
> >
> I plan to reuse this driver for iMX25, 35 & 51 based boards so this 
> parameter may change depending on machine_is_xxx macro.

Ok, I see. You will have a machine_is_blah() statement to select the
correct DAI.

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
