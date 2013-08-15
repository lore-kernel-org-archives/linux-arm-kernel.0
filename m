From: broonie@kernel.org (Mark Brown)
Date: Thu, 15 Aug 2013 12:09:19 +0100
Subject: [PATCH] regmap: Add another missing header for !CONFIG_REGMAP
 stubs
In-Reply-To: <1376521502-9370-1-git-send-email-khilman@linaro.org>
References: <1376521502-9370-1-git-send-email-khilman@linaro.org>
Message-ID: <20130815110919.GZ2401@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 04:05:02PM -0700, Kevin Hilman wrote:
> The use of WARN_ON() needs the definitions from bug.h, without it
> you can get:

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130815/68725475/attachment.sig>
