From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Wed, 15 Nov 2017 16:53:36 +0100
Subject: [PATCH v3 5/5] misc serdev: w2sg0004: add debugging code and
 Kconfig
In-Reply-To: <9b4969c858d4c3801bb796f92dad5c580799b768.1510759152.git.hns@goldelico.com>
References: <cover.1510759152.git.hns@goldelico.com>
 <9b4969c858d4c3801bb796f92dad5c580799b768.1510759152.git.hns@goldelico.com>
Message-ID: <28e16c7a-2688-a302-1548-1cdc2552f0ad@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 15.11.2017 um 16:19 schrieb H. Nikolaus Schaller:
> This allows to set CONFIG_W2SG0004_DEBUG which will
> make the driver report more activities and it will turn on the
> GPS module during boot while the driver assumes that it
> is off. This can be used to debug the correct functioning of
> the hardware. Therefore we add it as an option to the driver
> because we think it is of general use (and a little tricky to
> add by system testers).
> 
> Normally it should be off.
> ---

If you want to merge this, it is lacking a Sob.

Cheers,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
