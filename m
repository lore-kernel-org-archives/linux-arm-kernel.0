From: gnurou@gmail.com (Alexandre Courbot)
Date: Fri, 11 Apr 2014 11:44:04 +0900
Subject: [PATCH V3 4/5] mfd: palmas: support IRQ inversion at the board
 level
In-Reply-To: <5346BBDF.4050901@wwwdotorg.org>
References: <1393876300-3061-1-git-send-email-swarren@wwwdotorg.org>
 <1393876300-3061-4-git-send-email-swarren@wwwdotorg.org>
 <CAAVeFuJY67zdoHiZufxDbkaw=xt8YwxyDAwHW_T7UZeSOt35NA@mail.gmail.com>
 <5346BBDF.4050901@wwwdotorg.org>
Message-ID: <CAAVeFu++TPMG_TP1T2EEc5a04uqx_g2mtbrG1RWb2KLn+wvoxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 11, 2014 at 12:42 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 04/10/2014 01:04 AM, Alexandre Courbot wrote:
>> Stephen, any news about this patch? I'm waiting for it to be merged in
>> order to resend some Tegra DTs, but still cannot see it in -next.
>
> To be honest, this became too painful to work on just to fix a warning
> at boot which has no practical side-effect in our case. The best thing
> to do is just merge your DTs for 3.16, and keep ignoring the warning
> just like we always have on Dalmore. Hopefully at some point I (or
> someone) will run out of higher priority work items and get back to this.

Ok, fine by me. I will wait for -rc1, see if I can enable more devices
with 3.16 and send you the updated DTs soon after.

Thanks,
Alex.
