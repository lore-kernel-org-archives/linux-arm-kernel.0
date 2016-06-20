From: geoff@infradead.org (Geoff Levand)
Date: Mon, 20 Jun 2016 09:50:11 -0700
Subject: [PATCH v19 05/13] arm64/kexec: Add pr_debug output
In-Reply-To: <5768147E.1050900@arm.com>
References: <cover.1466120418.git.geoff@infradead.org>
 <dd245cadf97ea0d8fd5b0fe5743ecf9fa512d3c0.1466120418.git.geoff@infradead.org>
 <5768147E.1050900@arm.com>
Message-ID: <1466441411.7965.17.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-06-20 at 17:06 +0100, James Morse wrote:
> --- a/arch/arm64/kernel/machine_kexec.c
> > +++ b/arch/arm64/kernel/machine_kexec.c
> > @@ -11,6 +11,7 @@
> >  
> >  #include 
> >  #include 
> > +#include 
> 
> Now that the get_user(maybe_dtb_addr,.. has gone, I don't think we need this header.

No, we don't.  I have already fixed that in my master branch.

> >  
> >  #include 
> >  #include 
> 
> 
> Reviewed-by: James Morse <james.morse@arm.com>

Thanks again.

-Geoff
