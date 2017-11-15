From: hns@goldelico.com (H. Nikolaus Schaller)
Date: Wed, 15 Nov 2017 17:29:25 +0100
Subject: [PATCH v3 5/5] misc serdev: w2sg0004: add debugging code and
 Kconfig
In-Reply-To: <28e16c7a-2688-a302-1548-1cdc2552f0ad@suse.de>
References: <cover.1510759152.git.hns@goldelico.com>
 <9b4969c858d4c3801bb796f92dad5c580799b768.1510759152.git.hns@goldelico.com>
 <28e16c7a-2688-a302-1548-1cdc2552f0ad@suse.de>
Message-ID: <DC57A290-669C-4B3C-A4EE-2ABEA37F47CE@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas,

> Am 15.11.2017 um 16:53 schrieb Andreas F?rber <afaerber@suse.de>:
> 
> Hi,
> 
> Am 15.11.2017 um 16:19 schrieb H. Nikolaus Schaller:
>> This allows to set CONFIG_W2SG0004_DEBUG which will
>> make the driver report more activities and it will turn on the
>> GPS module during boot while the driver assumes that it
>> is off. This can be used to debug the correct functioning of
>> the hardware. Therefore we add it as an option to the driver
>> because we think it is of general use (and a little tricky to
>> add by system testers).
>> 
>> Normally it should be off.
>> ---
> 
> If you want to merge this, it is lacking a Sob.

Whats is a "Sob" in this context (https://acronyms.thefreedictionary.com/SOB)?

BR and thanks,
Nikolaus Schaller
