From: broonie@kernel.org (Mark Brown)
Date: Tue, 16 Apr 2013 17:22:57 +0100
Subject: [PATCH v5 00/14] ARM: samsung-time: Prepare for multiplatform
 support
In-Reply-To: <1365794250-14436-1-git-send-email-t.figa@samsung.com>
References: <1365794250-14436-1-git-send-email-t.figa@samsung.com>
Message-ID: <20130416162256.GM26958@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 12, 2013 at 09:17:16PM +0200, Tomasz Figa wrote:
> This series is an attempt to make the samsung-time clocksource driver ready
> for multiplatform kernels. It moves the driver to drivers/clocksource, cleans
> it up from uses of static platform-specific definitions, simplifies timer
> interrupt handling and adds Device Tree support.

Tested-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130416/4c95907a/attachment-0001.sig>
