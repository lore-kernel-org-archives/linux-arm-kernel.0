From: timur@tabi.org (Timur Tabi)
Date: Mon, 21 Oct 2013 06:21:03 -0500
Subject: [PATCHv1 5/8] ASoC: sgtl5000: Revise the bugs about the sgt15000
 codec.
In-Reply-To: <1DD289F6464F0949A2FCA5AA6DC23F82866756@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>	<1382000477-17304-6-git-send-email-Li.Xiubo@freescale.com>
 <20131017121721.43e1b34b@ipc1.ka-ro>
 <1DD289F6464F0949A2FCA5AA6DC23F82866756@039-SN2MPN1-013.039d.mgd.msft.net>
Message-ID: <52650E1F.9030102@tabi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Xiubo Li-B47053 wrote:
> The CONFIG_SND_SOC_FSL_SGTL5000 micro will be renamed to CONFIG_SND_SOC_FSL_SGTL5000_VF610.
> In VF610, there has not Power Manager Module, so whether the CONFIG_REGULATOR is enable or
> Disabled, there will always some errors booting...

That's just not acceptable.  You have to fix the code so that it works 
with CONFIG_REGULATOR both set and not set.
