From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 1 Apr 2013 14:53:08 +0100
Subject: [PATCH v7 09/14] spi/spi-atmel: correct 16 bits transfers using
 PIO
In-Reply-To: <1363679279-4045-1-git-send-email-wenyou.yang@atmel.com>
References: <1363678866-3567-1-git-send-email-wenyou.yang@atmel.com>
 <1363679279-4045-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20130401135308.GA18636@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 19, 2013 at 03:47:59PM +0800, Wenyou Yang wrote:
> From: Richard Genoud <richard.genoud@gmail.com>
> 
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> Cc: spi-devel-general at lists.sourceforge.net
> Cc: linux-kernel at vger.kernel.org
> [wenyou.yang at atmel.com: submit the patch]
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>

This looks like a bug fix to the exiting code rather than something new
for dmaengine - it should really have been sent at the start of the
series so it can be applied a bug fix and sent to mainline faster.

Some sort of description of what was wrong and how it got fixed would've
been good in the changelog.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130401/6507b9f4/attachment.sig>
