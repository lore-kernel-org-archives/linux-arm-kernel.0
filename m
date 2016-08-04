From: broonie@kernel.org (Mark Brown)
Date: Thu, 4 Aug 2016 22:03:23 +0100
Subject: [PATCH 3/8] ASoC: uda134x: Optionally initialize L3 ops to
 default GPIO ops
In-Reply-To: <1470317928-25365-4-git-send-email-s.nawrocki@samsung.com>
References: <1470317928-25365-1-git-send-email-s.nawrocki@samsung.com>
 <1470317928-25365-4-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20160804210323.GK10383@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2016 at 03:38:43PM +0200, Sylwester Nawrocki wrote:

> The downside is that it will request GPIOs on behalf of the codec
> device and thus allow only one user on the bus, but it desn't seem
> to be a limitation with current code and usage of the GPIO ops is
> optional anyway.

Does L3 actually support multiple devices?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160804/259c583f/attachment.sig>
