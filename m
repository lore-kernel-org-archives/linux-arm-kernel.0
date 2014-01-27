From: hs@denx.de (Heiko Schocher)
Date: Mon, 27 Jan 2014 07:22:18 +0100
Subject: GPIO triggers kernel reboot
In-Reply-To: <CALLGbRKK_ZcOB6nAiV67njrphXMQXN7Y2s81n5k3PWoSVrsrUw@mail.gmail.com>
References: <52E3E031.6040709@denx.de>
 <CALLGbRKK_ZcOB6nAiV67njrphXMQXN7Y2s81n5k3PWoSVrsrUw@mail.gmail.com>
Message-ID: <52E5FB1A.2020205@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Steve,

Thanks for your answer!

Am 25.01.2014 20:39, schrieb Steve deRosier:
> Hi Heiko,
>
> It's certainly possible, and it's also easily done from user-space.
>   Something like this is more policy than function.  It's also a potential
> security issue.  As such I'd expect it highly unlikely that the kernel
> maintainers would allow it to go upstream. Give it a try though.

Ok, thats what I also think ...

> I'd approach this from user-space.  Add in the gpio-keys driver and use the
> input-event-daemon to trigger a reboot.  Super easy.

Yes, that was also my suggestion, but is there a way to do this without
user space usage in a generic way?

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
