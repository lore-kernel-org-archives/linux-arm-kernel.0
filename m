From: mpe@ellerman.id.au (Michael Ellerman)
Date: Wed, 28 Jan 2015 12:04:34 +1100
Subject: [PATCH 0/4] defconfigs: cleanup obsolete MTD configs
In-Reply-To: <CAJOTznWHpRh8ysVxwSWyvZL1UAe-G9A64j=M6z0+zPeoycgkDg@mail.gmail.com>
References: <1422117213-3130-1-git-send-email-semen.protsenko@globallogic.com>
 <1422118156.27947.7.camel@x220>
 <CAJOTznWHpRh8ysVxwSWyvZL1UAe-G9A64j=M6z0+zPeoycgkDg@mail.gmail.com>
Message-ID: <1422407074.32234.2.camel@ellerman.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2015-01-24 at 22:54 +0200, Sam Protsenko wrote:
> > That's news for me. I thought they are silently ignored. Do you have an
> > example of such a warning?
> 
> Not really. It was just assumption. It seems you are right, they are just
> ignored silently. But item 2 is still relevant and it was actually confused
> me when I tried to figure out MTD configuration for my platform.
> Anyway, garbage should be taken out from time to time.

The usual way that this gets dealt with is that arch maintainers (ir)regularly
run make savedefconfig on all their defconfigs.

As it happens we've done that on powerpc just recently, if you rebase onto next
you should see that, so you can drop the powerpc hunks from your patches. 

cheers
