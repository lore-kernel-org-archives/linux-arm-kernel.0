From: triplesquarednine@gmail.com (jordan)
Date: Thu, 17 Apr 2014 21:15:50 -0400
Subject: BUG: spinlock trylock failure on UP - reverting timer patches
 helps
In-Reply-To: <CAOcfFMyTmQH-FwGE2YWoA76ypzBtWPYVTyi+4QpEMnrRtw8QVg@mail.gmail.com>
References: <534C3606.7010206@meduna.org> <534C731F.1050406@meduna.org>
 <534DADF1.6060608@meduna.org> <53500184.4050309@meduna.org>
 <53505BD7.9050004@meduna.org>
 <CAOcfFMyTmQH-FwGE2YWoA76ypzBtWPYVTyi+4QpEMnrRtw8QVg@mail.gmail.com>
Message-ID: <CAOcfFMz6U+w_h+0GoAB4OMbEGsDo_h=vCobvgxuBtLTijW3VmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey again,

> [ninez at localhost ~]$  (cat /proc/meminfo ; cat /proc/meminfo) |  grep
> KernelStack
> KernelStack:        3728 kB
> KernelStack:        3728 kB
> [ninez at localhost ~]$  (cat /proc/meminfo ; cat /proc/meminfo) |  grep
> KernelStack
> KernelStack:        3696 kB
> KernelStack:        3696 kB
>
> I'll post from my old kernel in a bit.

my other machines all report kstack as being stable/consistent - I
also had an Archlinux user of my kernel check his box - his was
consistent too. [all of those boxes reverted those timer patches].

cheerz

Jordan
