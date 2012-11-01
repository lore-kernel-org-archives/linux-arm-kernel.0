From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 1 Nov 2012 10:35:43 +0100
Subject: [PATCH RESEND] ARM: pxa27x_keypad: clear pending interrupts on
 keypad config
In-Reply-To: <87r4oiwin8.fsf@free.fr>
References: <1351439163-9575-1-git-send-email-anarsoul@gmail.com>
 <87vcduwkfa.fsf@free.fr>
 <CA+E=qVeETyX+jY+uKS5HAOymGOnF7x+sKGnmrQ0J=3CbnfVTNg@mail.gmail.com>
 <87r4oiwin8.fsf@free.fr>
Message-ID: <CAN1soZyq6F0G8F-eiA-zX2n8AAzp68URUWdf_4HsJ_OW++8u_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2012 at 2:34 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Vasily Khoruzhick <anarsoul@gmail.com> writes:
>
>> It behaves correctly, it just can't handle last keypress (because it's
>> booting Linux).
>> Even if it would be possible to fix this issue in bootloader it's
>> always nice to keep driver
>> failure-proof, so it does not fail even if bootloader left something
>> in non-consistent state.
> True.
> Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
>
> --
> Robert

Applied

Thanks
Haojian
