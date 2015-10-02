From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Fri, 2 Oct 2015 14:16:50 -0300
Subject: Queueing b0a688ddcc50 "usb: musb: cppi41: allow it to work again"
 for -stable
In-Reply-To: <20151002160902.GF5552@saruman.tx.rr.com>
References: <CAAEAJfC7z=dvw_5vgXDBWVQdKA5jDpfECYv4Jy67YaT7219uJA@mail.gmail.com>
 <20151002160902.GF5552@saruman.tx.rr.com>
Message-ID: <CAAEAJfALjV2BCJwzd20TQA3CWa1VZRM5vPv6CydrBuMJc=vVAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 October 2015 at 13:09, Felipe Balbi <balbi@ti.com> wrote:
> On Fri, Oct 02, 2015 at 02:23:45AM -0300, Ezequiel Garcia wrote:
>> Hello,
>>
>> Commit b0a688ddcc50 "usb: musb: cppi41: allow it to work again" seems
>> to fix a regression. It applies cleanly on v4.1 and removes the
>> "musb-hdrc musb-hdrc.1.auto: Need DT for the DMA engine." error.
>>
>> Any chance you can queue it for -stable?
>
> Have a look at Documentation/stable_kernel_rules.txt, you can do a proper
> request for Greg and he will make sure it gets there.
>

Sure, I will.

Maybe next time you could add a Cc: stable to these kinds of fixes, along with
a proper Fixes tag, so the -stable folks can pick them automatically.

Thanks!
-- 
Ezequiel Garc?a, VanguardiaSur
www.vanguardiasur.com.ar
