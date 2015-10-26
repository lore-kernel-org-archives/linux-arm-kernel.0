From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Mon, 26 Oct 2015 10:01:32 -0300
Subject: [PATCH] ARM: v7-M: Use ret_to_user_from_irq in PendSV handler
In-Reply-To: <20151026075059.GV4931@pengutronix.de>
References: <1445818252-13175-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <20151026075059.GV4931@pengutronix.de>
Message-ID: <CAAEAJfDibM91GSAzP+QGgj37CURJev13dHJKrLp5nWGBJ9WKAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 October 2015 at 04:50, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Sun, Oct 25, 2015 at 09:10:52PM -0300, Ezequiel Garcia wrote:
>> The PendSV handler calls v7m_exception_entry which
>> disables IRQs. Therefore, since IRQs are already disabled,
>> the PendSV handler can return using ret_to_user_from_irq.
>>
>> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> Looks right. How did you notice this?
>

Just reading the code.

> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>

Thanks, I'll queue this in Russell's patch tracking system.
-- 
Ezequiel Garc?a, VanguardiaSur
www.vanguardiasur.com.ar
