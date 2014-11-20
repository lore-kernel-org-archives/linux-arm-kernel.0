From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 20 Nov 2014 10:17:08 +0100
Subject: [RFC PATCH] serial: mxs-auart: Take missing uart port locks
In-Reply-To: <1416322001-28491-1-git-send-email-j.uzycki@elproma.com.pl>
References: <1416322001-28491-1-git-send-email-j.uzycki@elproma.com.pl>
Message-ID: <546DB194.40902@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Janusz,

Am 18.11.2014 um 15:46 schrieb Janusz Uzycki:
> The patch adds missing spin-locks and allows to change termios
> settings during tx.
> The patch also fixes direct call its enable_ms() according to
> commit d41510ce2f07
> ("serial: Take uart port lock for direct *_enable_ms()")

i think it's better to separate it in different patches.

Best regards
Stefan
