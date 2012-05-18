From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 18 May 2012 08:36:03 +0100
Subject: [PATCH 09/18] regulator: ab8500: Split up probe() into
 manageable pieces
In-Reply-To: <1337262323-27692-10-git-send-email-lee.jones@linaro.org>
References: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
 <1337262323-27692-10-git-send-email-lee.jones@linaro.org>
Message-ID: <20120518073603.GC4073@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2012 at 02:45:14PM +0100, Lee Jones wrote:
> ab8500's probe() function is becoming quite large, so in the lead
> up to Device Tree enablement which will fork the thread of execution
> this patch splits it into 3 main areas; basic error checking will
> remain in probe(), but regulator register initialisation and regulator
> registration have been moved to their own functions which will
> be called in sequence by probe() and the DT equivalent.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120518/f852959b/attachment.sig>
