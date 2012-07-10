From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 10 Jul 2012 16:42:01 +0100
Subject: [PATCH 1/3] ARM: dt: tegra: seaboard: add regulators
In-Reply-To: <4FFC4478.7000204@nvidia.com>
References: <4FE80413.6070001@nvidia.com> <4FE87FE3.1080608@wwwdotorg.org>
 <4FE882A5.3080504@nvidia.com>
 <20120625222646.GB30406@opensource.wolfsonmicro.com>
 <4FE8EFC4.3090509@wwwdotorg.org> <4FFC190A.2040800@nvidia.com>
 <20120710134436.GD9409@opensource.wolfsonmicro.com>
 <4FFC31D5.7090600@nvidia.com>
 <20120710135302.GG9409@opensource.wolfsonmicro.com>
 <4FFC4478.7000204@nvidia.com>
Message-ID: <20120710154201.GE10022@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2012 at 08:34:24PM +0530, Laxman Dewangan wrote:

> The sample code for tps65910 is as follows. So where do you think
> that it is wrong and what should be correct approach.
> I need to follow the same for tps6586x also.

Like I said the use of a supply name should be unconditional, you should
just set the supply name in the descriptor.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120710/75a398e8/attachment-0001.sig>
