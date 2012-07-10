From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 10 Jul 2012 14:53:03 +0100
Subject: [PATCH 1/3] ARM: dt: tegra: seaboard: add regulators
In-Reply-To: <4FFC31D5.7090600@nvidia.com>
References: <1340406842-27135-1-git-send-email-swarren@wwwdotorg.org>
 <4FE80413.6070001@nvidia.com> <4FE87FE3.1080608@wwwdotorg.org>
 <4FE882A5.3080504@nvidia.com>
 <20120625222646.GB30406@opensource.wolfsonmicro.com>
 <4FE8EFC4.3090509@wwwdotorg.org> <4FFC190A.2040800@nvidia.com>
 <20120710134436.GD9409@opensource.wolfsonmicro.com>
 <4FFC31D5.7090600@nvidia.com>
Message-ID: <20120710135302.GG9409@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2012 at 07:14:53PM +0530, Laxman Dewangan wrote:

> Sorry, I did not get it fully. I had two patches, one for fixed one
> and other for tps65910. On which patch, you are seeing issue and
> which part of code?

Mainly tps65910.  The fixed voltage regulator does have the same issue
but it is somewhat special here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120710/c0c51521/attachment.sig>
