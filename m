From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 28 Mar 2013 00:13:53 +0000
Subject: [PATCH 21/46] regulator: ab8500: Correct TVOUT regulator
 start-up delay
In-Reply-To: <1363881583-15234-22-git-send-email-lee.jones@linaro.org>
References: <1363881583-15234-1-git-send-email-lee.jones@linaro.org>
 <1363881583-15234-22-git-send-email-lee.jones@linaro.org>
Message-ID: <20130328001353.GN18316@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 03:59:18PM +0000, Lee Jones wrote:
> From: Jonas Aaberg <jonas.aberg@stericsson.com>
> 
> Update TVOUT regulator to match specification. (Was 10ms,
> changed to 500us.)

This fails to apply due to Axel's changes which remove delay entirely...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130328/6563c5f4/attachment.sig>
