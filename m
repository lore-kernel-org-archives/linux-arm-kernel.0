From: jrbenito@benito.qsl.br (Josenivaldo Benito Junior)
Date: Fri, 27 Jul 2012 14:52:46 -0000
Subject: Adding new board to Kernel
Message-ID: <CAOYb-CL9WM8wzko7CsQvYAAWKARnTkrqenBtsgchn96t=x4wyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi there,

The Embedded Artists has a board based on ARM LPC3250 called EA3250 and
they provide a BSP with patch to Linux Kernel version 2.6.29.2. I am trying
to "up merge" this patch to Kernel v3.4 (now 3.5) and after that get it in
the mainstream. Although I have a working version (
https://github.com/jrbenito/Kernel-LPC3250) I still have doubts on how to
correct submit it to mainline kernel.

-The machine type is already registered in past (
http://www.arm.linux.org.uk/developer/machines/list.php?id=2512) but it is
not in mainline. Since I shall not patch this file, how can I ask to it be
updated with ea3250 board information?

-Could you please point me any documentation on how to add board support to
Linux Kernel?

My doubts are mainly related with process and order of files to submit I
shall follow. Any direction will be strongly appreciated.

Thanks and best regards,

--*
Josenivaldo Benito Jr.*
*PU2LBD*

*Por Aur?lio Buarque de Hollanda,  elite, do franc?s ?lite, significa ?o
que h? de melhor em uma sociedade, minoria prestigiada, constitu?da pelos
indiv?duos mais aptos?.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120727/ea2d558b/attachment-0001.html>
