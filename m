From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 11 Mar 2012 11:13:54 -0300
Subject: [PATCH 3/4] mx31moboard: Add ssi configuration
In-Reply-To: <20120311114104.GC3233@opensource.wolfsonmicro.com>
References: <1331304916-4724-1-git-send-email-philippe.retornaz@epfl.ch>
 <1331304916-4724-2-git-send-email-philippe.retornaz@epfl.ch>
 <1331304916-4724-3-git-send-email-philippe.retornaz@epfl.ch>
 <1331304916-4724-4-git-send-email-philippe.retornaz@epfl.ch>
 <20120311114104.GC3233@opensource.wolfsonmicro.com>
Message-ID: <CAOMZO5Ao2u71AixumSUgG8BbqL_BPYw-yKjkmZOj0ygkqLRdtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Philippe,

2012/3/11 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Fri, Mar 09, 2012 at 03:55:15PM +0100, Philippe R?tornaz wrote:
>
>> + ? ? mxc_audmux_v2_configure_port(MX31_AUDMUX_PORT1_SSI0,
>> + ? ? ? ? ? ? MXC_AUDMUX_V2_PTCR_SYN |
>> + ? ? ? ? ? ? MXC_AUDMUX_V2_PTCR_TFSDIR |
>
> This will need to be rebased off current code, the audmux has been moved
> into sound/soc.

You can use linux-next tree as it already contains the recent audmux changes.

Thanks,

Fabio Estevam
