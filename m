From: broonie@kernel.org (Mark Brown)
Date: Wed, 27 Nov 2013 17:14:39 +0000
Subject: [PATCH V2] ASoC: tegra: use reset framework
In-Reply-To: <1385496767-8307-1-git-send-email-swarren@wwwdotorg.org>
References: <1385496767-8307-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131127171439.GM14725@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 01:12:47PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Tegra's clock driver now provides an implementation of the common
> reset API (include/linux/reset.h). Use this instead of the old Tegra-
> specific API; that will soon be removed.

Acked-by: Mark Brown <broonie@linaro.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131127/2d82c946/attachment.sig>
