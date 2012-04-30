From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 30 Apr 2012 23:48:21 +0100
Subject: [PATCH] ASoC: tegra: add device tree support for TrimSlice
In-Reply-To: <1335555259-9263-1-git-send-email-swarren@wwwdotorg.org>
References: <1335555259-9263-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20120430224821.GB27450@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 01:34:19PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> This binding doesn't include the nvidia,model or nvidia,audio-routing
> properties the other Tegra audio DT bindings have, because this binding
> is targetted at a single machine, rather than for any machine using the
> tlv320aic23 codec.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120430/79f4d830/attachment-0001.sig>
