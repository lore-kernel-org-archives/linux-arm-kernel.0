From: will.deacon@arm.com (Will Deacon)
Date: Sun, 27 Nov 2011 12:56:56 +0000
Subject: [PATCH 1/1 v5] arm: fault.c: Port OOM changes into do_page_fault
In-Reply-To: <CAFPAmTTWVwq8H6HVzdvTcN-jcSoNQ2-TfLWT33ks8_kpGND+SA@mail.gmail.com>
References: <1321986690-6079-1-git-send-email-consul.kautuk@gmail.com>
 <20111126235032.GC9581@n2100.arm.linux.org.uk>
 <CAFPAmTTWVwq8H6HVzdvTcN-jcSoNQ2-TfLWT33ks8_kpGND+SA@mail.gmail.com>
Message-ID: <20111127125656.GA26042@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 27, 2011 at 05:58:33AM +0000, Kautuk Consul wrote:
> >
> > Thanks. ?I think this is fine. ?Please put it in the patch system so it's
> > not forgotten, and I'll get to it sometime during the next week. ?Thanks.
> >
> 
> Thanks. I don't know what you mean by "put it in the patch system" as I already
> did a "git send-email" for this patch to this mailing list.
> 
> So, please find the v5 patch file attached to this email for any
> further reference.

You should read the documentation here:

http://www.arm.linux.org.uk/developer/patches/info.php

and then you can use git send-email --suppress-cc=all to email your patch to
the patch system, making sure you have the correct KernelVersion tag.

Will
