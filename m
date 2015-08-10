From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 10 Aug 2015 15:04:16 +0200
Subject: memory leak ?
In-Reply-To: <CAOdCjQuQ09-UWNjaZncYfC0HASOzuCS-jMU2mv7K7je+shQyoA@mail.gmail.com>
References: <CAOdCjQuQ09-UWNjaZncYfC0HASOzuCS-jMU2mv7K7je+shQyoA@mail.gmail.com>
Message-ID: <CABxcv=nmedvr4jm=ffd135LjVKE8kCLp5xUqiQatvne-aECH4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Pankaj,

On Mon, Aug 10, 2015 at 2:57 PM, Pankaj Pandey
<pankaj.embedded@gmail.com> wrote:
> Hi All,
>
> I am using 3.10 kernel on armv7 target board. We  observed  that
> Active(file), Inactive(file) and Buffers sections in /proc/meminfo
> have shown increase in memory usage even though none of the processes
> running in the system show increased memory usage. Please find log
> below:
>
>
> Log at 5 min
> Buffers:           23164 kB
> Active(file):      35128 kB
> Inactive(file):    97032 kB
>
>
> log at  30 min.
> Buffers:           65960 kB
> Active(file):      76024 kB
> Inactive(file):   117180 kB
>
> Is this a memory leak ? if yes how we can capture who is consuming these
> memories.
>

Did you already try enabling the Kernel Memory Leak Detector [0]?

> Regards,
> Pankaj
>

Best regards,
Javier

[0]: https://www.kernel.org/doc/Documentation/kmemleak.txt
