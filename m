From: panand@redhat.com (Pratyush Anand)
Date: Fri, 29 Jul 2016 22:47:35 +0530
Subject: [PATCH v23 0/9] arm64: add kdump support
In-Reply-To: <1469812107.16559.37.camel@infradead.org>
References: <20160726075659.2290-1-takahiro.akashi@linaro.org>
 <20160726080925.GA2363@linaro.org>
 <CAB=otbTODnOwFiLZT7bm1_MLyORQ1cx-gaeg7bm+bReaMRhYwg@mail.gmail.com>
 <1469812107.16559.37.camel@infradead.org>
Message-ID: <20160729171735.GC478@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/07/2016:10:08:27 AM, Geoff Levand wrote:
> Hi,
> 
> On Fri, 2016-07-29 at 19:26 +0300, Ruslan Bilovol wrote:
> 
> > Also for some reason in case of 'load and kexec the kernel' it
> > takes 1-2 minutes to start booting after I do kexec -e, need to
> > investigate it further.
> 
> You could try my patch ("purgatory: Change default sha256
> optimization to -O2") in my master branch:

Yep, that did bring my 2 Min 30 sec to almost 20 sec, and then it came down to
fraction of second after D-cache enabling.

~Pratyush
> 
>   https://git.kernel.org/cgit/linux/kernel/git/geoff/kexec-tools.git/log/
> 
> Other have said it helped.
> 
> -Geoff
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
