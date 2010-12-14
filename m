From: yong.shen@linaro.org (Yong Shen)
Date: Tue, 14 Dec 2010 12:06:15 +0800
Subject: [PATCHv4] regulator: support PMIC mc13892
In-Reply-To: <1292253326.3320.82.camel@odin>
References: <1292231217-4121-1-git-send-email-yong.shen@freescale.com>
	<1292231217-4121-2-git-send-email-yong.shen@freescale.com>
	<1292253326.3320.82.camel@odin>
Message-ID: <AANLkTimKpfo6-9OEYbP8wiVwFXn4_Ch+FSvHDvoqhu5e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 13, 2010 at 11:15 PM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> On Mon, 2010-12-13 at 17:06 +0800, yong.shen at freescale.com wrote:
>> From: Yong Shen <yong.shen@linaro.org>
>>
>> add support for mc13892, tested on mx51 babbage board
>>
>> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
>> Signed-off-by: Yong Shen <yong.shen@linaro.org>
>> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
>> Acked-by: Samuel Ortiz <sameo@linux.intel.com>
>> ---
>> ?drivers/regulator/Kconfig ? ? ? ? ? ? | ? ?8 +
>> ?drivers/regulator/Makefile ? ? ? ? ? ?| ? ?1 +
>> ?drivers/regulator/mc13892-regulator.c | ?635 +++++++++++++++++++++++++++++++++
>> ?include/linux/mfd/mc13892.h ? ? ? ? ? | ? 39 ++
>> ?4 files changed, 683 insertions(+), 0 deletions(-)
>> ?create mode 100644 drivers/regulator/mc13892-regulator.c
>> ?create mode 100644 include/linux/mfd/mc13892.h
>>
>
> Applied.
>
> Can you check regulator for-next as one of your previous patches may
> have been missed.
>
There were two patches posted previously, they are:
Change-the-register-name-definitions-for-mc13783
make-mc13783-regulator-code-generic
I think these two should be applied before mc13892 patch.

Since they may not be applied on your tree, I will resend them based
on your 'for-next' tree.

Cheers
Yong
