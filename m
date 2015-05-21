From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Thu, 21 May 2015 09:42:32 +0200
Subject: [PATCH v8 01/16] scripts: link-vmlinux: Don't pass page offset to
 kallsyms if XIP Kernel
In-Reply-To: <555D6FBD.3020202@suse.cz>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1431158038-3813-2-git-send-email-mcoquelin.stm32@gmail.com>
 <CALszF6B0=dgSDfLFwDi9YmEzrrNVuYbUnqMu5DmDhhy--emtpw@mail.gmail.com>
 <555D12F8.4000403@suse.de> <555D6FBD.3020202@suse.cz>
Message-ID: <CALszF6AdNfYRhcLdc252peOcPOnzAXOKQydNcvgVdT26btAA6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-21 7:40 GMT+02:00 Michal Marek <mmarek@suse.cz>:
> Dne 21.5.2015 v 07:04 Andreas F?rber napsal(a):
>> Am 18.05.2015 um 13:47 schrieb Maxime Coquelin:
>> But this is definitely an improvement for ARMv7-M debugging,
>>
>> Tested-by: Andreas F?rber <afaerber@suse.de>
>>
>>> [Hi Michal, ...] could you consider
>>> taking it for v4.2?
>
> I applied it to kbuild.git#kbuild now.

Thanks!
Maxime
