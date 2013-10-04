From: broonie@kernel.org (Mark Brown)
Date: Fri, 4 Oct 2013 17:41:39 +0100
Subject: [PATCH] clk: palmas: add clock driver for palmas
In-Reply-To: <1380803407-15196-1-git-send-email-ldewangan@nvidia.com>
References: <1380803407-15196-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <20131004164139.GR27287@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 03, 2013 at 06:00:07PM +0530, Laxman Dewangan wrote:

> +	Optional subnode properties:
> +	ti,clock-boot-enable: Enable clock at the time of booting.

Shouldn't this be a generic clock subsystem thing?  It seems like
something that might be desired for nearly any clock.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131004/ea8619ef/attachment.sig>
