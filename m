From: broonie@kernel.org (Mark Brown)
Date: Tue, 2 Jul 2013 19:13:48 +0100
Subject: [PATCH] ASoC: ttc_dkb: add .owner to struct snd_soc_card
In-Reply-To: <CAPgLHd_CJUYf8Ry=J9Y8ZPSrCgqPLTj74rDr__bxoymQ8GR_1A@mail.gmail.com>
References: <CAPgLHd_CJUYf8Ry=J9Y8ZPSrCgqPLTj74rDr__bxoymQ8GR_1A@mail.gmail.com>
Message-ID: <20130702181348.GV27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 02, 2013 at 05:26:40PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Add missing .owner of struct snd_soc_card. This prevents the
> module from being removed from underneath its users.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130702/fc4a27d7/attachment.sig>
