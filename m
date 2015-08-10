From: pankaj.embedded@gmail.com (Pankaj Pandey)
Date: Mon, 10 Aug 2015 18:27:30 +0530
Subject: memory leak ?
Message-ID: <CAOdCjQuQ09-UWNjaZncYfC0HASOzuCS-jMU2mv7K7je+shQyoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

I am using 3.10 kernel on armv7 target board. We  observed  that
Active(file), Inactive(file) and Buffers sections in /proc/meminfo
have shown increase in memory usage even though none of the processes
running in the system show increased memory usage. Please find log
below:


Log at 5 min
Buffers:           23164 kB
Active(file):      35128 kB
Inactive(file):    97032 kB


log at  30 min.
Buffers:           65960 kB
Active(file):      76024 kB
Inactive(file):   117180 kB

Is this a memory leak ? if yes how we can capture who is consuming these
memories.

Regards,
Pankaj
