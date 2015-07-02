From: balbi@ti.com (Felipe Balbi)
Date: Thu, 2 Jul 2015 07:10:45 -0500
Subject: [PATCH 0/2] ARM: DTS: am437x-sk-evm: Use simple-card for audio
 support
In-Reply-To: <1435838286-30491-1-git-send-email-peter.ujfalusi@ti.com>
References: <1435838286-30491-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20150702121045.GC5837@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 02, 2015 at 02:58:04PM +0300, Peter Ujfalusi wrote:
> Hi,
> 
> There is no reason to use the davinci-evm machine driver's compatible for audio
> support since the setup is simple and the common simple-audio-card can handle it
> just fine.
> Also add McASP1 sleep pin configuration.
> 
> Regards,
> Peter
> ---
> Peter Ujfalusi (2):
>   ARM: DTS: am437x-sk-evm: Add sleep pin settings for mcasp1
>   ARM: DTS: am437x-sk-evm: Switch using simple-audio-card for audio
>     support

you should add a patch enabling CONFIG_SND_SIMPLE_CARD=m in
omap2plus_defconfig

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150702/7317d566/attachment.sig>
