From: bhuvanchandra.dv@toradex.com (BhuvanChandra.DV)
Date: Wed, 28 Jan 2015 07:05:55 +0000
Subject: [PATCH 3/7] spi: spi-fsl-dspi: Remove usage of devm_kzalloc
In-Reply-To: <20150127195234.GP21293@sirena.org.uk>
References: <1422356244-15629-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <1422356244-15629-4-git-send-email-bhuvanchandra.dv@toradex.com>
 <20150127195234.GP21293@sirena.org.uk>
Message-ID: <1422429099979.36592@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 01/28/2015 01:22 AM, Mark Brown wrote:
> On Tue, Jan 27, 2015 at 04:27:20PM +0530, Bhuvanchandra DV wrote:
>> devm_* API was supposed to be used only in probe function call.
>> Memory is allocated at 'probe' and free automatically at 'remove'.
> Applied, thanks.  Please don't dump entire backtraces into your commit
> logs - they're far too big and not very helpful, they can obscure real
> content in the message.  Explain in words what the problem is and if a
> backtrace helps illustrate that edit it down to only relevant portions
> rather than blindly including the entire thing.

OK
