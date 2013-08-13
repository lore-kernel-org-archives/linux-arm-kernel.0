From: zonque@gmail.com (Daniel Mack)
Date: Tue, 13 Aug 2013 17:51:38 +0200
Subject: [PATCHv3 0/9] ARM: OMAP2+: AM33XX: Add suspend-resume support
In-Reply-To: <520A51B0.3010805@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
 <52077B26.1010103@gmail.com> <5209307F.9000701@ti.com>
 <520A28E5.9030304@gmail.com> <520A51B0.3010805@ti.com>
Message-ID: <520A560A.80609@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.08.2013 17:33, Dave Gerlach wrote:
> On 08/13/2013 07:39 AM, Daniel Mack wrote:

>> ... but traffic on UART0 won't cause a resume.
>>
> 
> It looks like you are using no_console_suspend? UART0 does not work as a 
> wakeup source with this option set.

Meh. Sorry, I didn't think about that possibility. Indeed, without that
option, it does resume. Now I can search for the reason why other wakeup
sources won't work yet, but that shouldn't bother you.


Thanks again,
Daniel
