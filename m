From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Tue, 11 Jun 2013 07:34:55 +0200
Subject: [PATCH 4/9] ARM: dma-mapping: NULLify dev->archdata.mapping
 pointer on detach
In-Reply-To: <1370889285-22799-5-git-send-email-will.deacon@arm.com>
References: <1370889285-22799-1-git-send-email-will.deacon@arm.com><1370889285-22799-5-git-send-email-will.deacon@arm.com>
Message-ID: <20130611.083455.1500863288897785600.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

Will Deacon <will.deacon@arm.com> wrote @ Mon, 10 Jun 2013 20:34:40 +0200:

> The current code only clobbers a local variable, so the device is left
> with a stale mapping pointer.

True. This's my bad. Thanks.
