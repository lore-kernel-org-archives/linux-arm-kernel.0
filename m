From: broonie@kernel.org (Mark Brown)
Date: Tue, 12 May 2015 19:07:39 +0100
Subject: [PATCH] ASoC: dapm: Modify widget stream name according to prefix
In-Reply-To: <1431311813-37430-1-git-send-email-koro.chen@mediatek.com>
References: <1431311813-37430-1-git-send-email-koro.chen@mediatek.com>
Message-ID: <20150512180738.GN3066@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 11, 2015 at 10:36:53AM +0800, Koro Chen wrote:
> When there is prefix specified, currently we will add this prefix in
> widget->name, but not in widget->sname.
> it causes failure at snd_soc_dapm_link_dai_widgets:

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150512/a9493189/attachment.sig>
