From: zonque@gmail.com (Daniel Mack)
Date: Sat, 4 Jun 2011 09:45:25 +0200
Subject: [stable] [PATCH] MTD: pxa3xx_nand: fix nand detection issue
In-Reply-To: <20110603223226.GC9161@kroah.com>
References: <BANLkTimos3-Ds4Y8FDfDZegqAhH7nSS4PA@mail.gmail.com>
	<1305865207-7869-1-git-send-email-leiwen@marvell.com>
	<BANLkTinuqQmp43K4H0iPDbb-H-rDA_nL9w@mail.gmail.com>
	<20110603223226.GC9161@kroah.com>
Message-ID: <BANLkTi=GEV3xfAZ+UphPPSG2hZavchiwPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 4, 2011 at 12:32 AM, Greg KH <greg@kroah.com> wrote:
> On Fri, Jun 03, 2011 at 11:11:54PM +0800, Lei Wen wrote:
>> Tested-by: Daniel Mack <zonque@gmail.com>
>>
>> Also cc to MTD maillist and stable kernel.
>
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree. ?Please read Documentation/stable_kernel_rules.txt
> for how to do this properly.
>
> </formletter>

Jup.

Lei - when you collect the patches for this driver to send them out,
make sure every one gets a "Cc: stable at kernel.org" line under the
S-o-b, so it can be picked automatically later on.

Just to be sure, I count four patches now:

 - 1 from you regarding keep_config chip detection and DMA support
(which is *not* the one this thread refers to, you sent an amended
version to me privately, and it might make sense to split this patch
again)
 - 1 from me for the blank page ECC issue
 - 2 from Alex Lin (one for removal of unused variable, one plugs a memory leak)


Thanks,
Daniel
