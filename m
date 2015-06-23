From: broonie@kernel.org (Mark Brown)
Date: Tue, 23 Jun 2015 12:11:15 +0100
Subject: [PATCH] ASoC: mediatek: Fix unbalanced calls to runtime
 suspend/resume
In-Reply-To: <1435057280-21316-1-git-send-email-koro.chen@mediatek.com>
References: <1435057280-21316-1-git-send-email-koro.chen@mediatek.com>
Message-ID: <20150623111115.GC14071@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 23, 2015 at 07:01:20PM +0800, Koro Chen wrote:
> This adds call to runtime suspend in dev remove. It fixs the problem that
> suspend is not called in the case of CONFIG_PM=n. It also fixs build
> warning when CONFIG_PM=n.

Applied, thanks (the stub does the right thing here if !CONFIG_PM).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150623/5fc19c56/attachment.sig>
