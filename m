From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 5 Nov 2012 21:48:14 +0300
Subject: pxa27x_keypad status
In-Reply-To: <87fw4nvqfs.fsf@free.fr>
References: <87fw4nvqfs.fsf@free.fr>
Message-ID: <CA+E=qVc37ZB-mfbJxFVWCVsOC_4Rx7bjzMMkouiTNhhEqATnsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 5, 2012 at 9:45 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Hi guys,
>
> Did you test out lately pxa27x_keypad driver ?
> I just passed a single test on 3.7-rc4, and I have no events. Moreover, if I do
> a "cat /proc/interrupts", the keypad interrupts number remains constant, even if
> I press keys :
>>  4:          6        SC  pxa27x-keypad
>
> Are keypad keys on PXA27x SoCs working for you ?

Hi Robert,

3.7-rc2 works for me except suspend/resume issue (does not work after resume)
I've just reverted 6ce34a5fb4955fac1eebe080e1c2784bc8710449 as
temporary workaround.

Regards
Vasily
