From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 5 Jun 2012 11:42:01 +0100
Subject: [PATCH 09/22] regulator: Change db8500-prcmu match names to
 reflect Device Tree
In-Reply-To: <4FCDE0A4.8070107@linaro.org>
References: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
 <1338353260-10097-10-git-send-email-lee.jones@linaro.org>
 <4FCDDE58.5010501@linaro.org>
 <20120605102900.GP23408@opensource.wolfsonmicro.com>
 <4FCDE0A4.8070107@linaro.org>
Message-ID: <20120605104201.GR23408@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 05, 2012 at 11:34:12AM +0100, Lee Jones wrote:

> >>Are you sending this for -rc2?

> >No, nothing about this looks like an urgent fix?

> Well without it all regulator requests from DT will fail.

Oh, ffs.  Why wasn't this mentioned when the patch was posted, and how
were the original patches tested?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120605/eb2d8aad/attachment.sig>
