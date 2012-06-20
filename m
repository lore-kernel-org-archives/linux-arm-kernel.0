From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 20 Jun 2012 14:08:41 +0100
Subject: [PATCH 08/15] regulator: Stop initialising AB8500's registers
 during bring-up
In-Reply-To: <1340197011-5435-9-git-send-email-lee.jones@linaro.org>
References: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
 <1340197011-5435-9-git-send-email-lee.jones@linaro.org>
Message-ID: <20120620130840.GM3978@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2012 at 01:56:44PM +0100, Lee Jones wrote:
> There is no need to initialise the AB8500's regulator registers, as
> most of this work is already carried out by framework features.

Does this have any dependency on the rest of the series?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120620/8fe6cae5/attachment.sig>
