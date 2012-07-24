From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 24 Jul 2012 20:20:08 +0100
Subject: [PATCH 3/4] ASoC: sgtl5000: remove unneeded
 snd_soc_dapm_new_widgets in probe
In-Reply-To: <1342776027-31758-4-git-send-email-b29396@freescale.com>
References: <1342776027-31758-1-git-send-email-b29396@freescale.com>
 <1342776027-31758-4-git-send-email-b29396@freescale.com>
Message-ID: <20120724192008.GE3099@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2012 at 05:20:26PM +0800, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> There's a driver bug that sgtl5000 dapm widget kcontrols do not work.
> e.g. can not select capture mux with amixer tool(no error info prompted).

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120724/1e88b86f/attachment.sig>
