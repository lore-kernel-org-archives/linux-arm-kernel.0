From: mmarek@suse.cz (Michal Marek)
Date: Thu, 21 May 2015 13:40:13 +0800
Subject: [PATCH v8 01/16] scripts: link-vmlinux: Don't pass page offset
 to kallsyms if XIP Kernel
In-Reply-To: <555D12F8.4000403@suse.de>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1431158038-3813-2-git-send-email-mcoquelin.stm32@gmail.com>
 <CALszF6B0=dgSDfLFwDi9YmEzrrNVuYbUnqMu5DmDhhy--emtpw@mail.gmail.com>
 <555D12F8.4000403@suse.de>
Message-ID: <555D6FBD.3020202@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne 21.5.2015 v 07:04 Andreas F?rber napsal(a):
> Am 18.05.2015 um 13:47 schrieb Maxime Coquelin:
> But this is definitely an improvement for ARMv7-M debugging,
> 
> Tested-by: Andreas F?rber <afaerber@suse.de>
> 
>> [Hi Michal, ...] could you consider
>> taking it for v4.2?

I applied it to kbuild.git#kbuild now.

Thanks,
Michal
