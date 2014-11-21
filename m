From: j.uzycki@elproma.com.pl (=?UTF-8?B?SmFudXN6IFXFvHlja2k=?=)
Date: Fri, 21 Nov 2014 12:32:43 +0100
Subject: [RFC PATCH] serial: mxs-auart: Take missing uart port locks
In-Reply-To: <546DB194.40902@i2se.com>
References: <1416322001-28491-1-git-send-email-j.uzycki@elproma.com.pl>
 <546DB194.40902@i2se.com>
Message-ID: <546F22DB.3060703@elproma.com.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Stefan,

W dniu 2014-11-20 o 10:17, Stefan Wahren pisze:
>
> Am 18.11.2014 um 15:46 schrieb Janusz Uzycki:
>> The patch adds missing spin-locks and allows to change termios
>> settings during tx.
>> The patch also fixes direct call its enable_ms() according to
>> commit d41510ce2f07
>> ("serial: Take uart port lock for direct *_enable_ms()")
> i think it's better to separate it in different patches.

OK, I separated them. I will send the patch again in near future but now I'm
waiting for more comments/tests.

thanks,
Janusz
