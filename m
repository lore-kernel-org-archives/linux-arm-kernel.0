From: broonie@kernel.org (Mark Brown)
Date: Tue, 26 May 2015 10:53:33 +0100
Subject: [PATCH 2/2] ASoC: atmel: compile pcm driver in
 snd-soc-atmel_ssc_dai
In-Reply-To: <1432591459-22613-2-git-send-email-alexandre.belloni@free-electrons.com>
References: <1432591459-22613-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1432591459-22613-2-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150526095333.GK21577@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 26, 2015 at 12:04:19AM +0200, Alexandre Belloni wrote:
> It is currently possible to have CONFIG_SND_ATMEL_SOC_SSC=y with either
> CONFIG_SND_ATMEL_SOC_PDC=m or CONFIG_SND_ATMEL_SOC_DMA=m. This results in a
> driver that compiles but does not link with this kind of error:

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150526/da5daf89/attachment.sig>
