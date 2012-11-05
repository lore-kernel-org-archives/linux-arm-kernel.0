From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 05 Nov 2012 19:45:59 +0100
Subject: pxa27x_keypad status
Message-ID: <87fw4nvqfs.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

Did you test out lately pxa27x_keypad driver ?
I just passed a single test on 3.7-rc4, and I have no events. Moreover, if I do
a "cat /proc/interrupts", the keypad interrupts number remains constant, even if
I press keys :
>  4:          6        SC  pxa27x-keypad

Are keypad keys on PXA27x SoCs working for you ?

Cheers.

-- 
Robert
