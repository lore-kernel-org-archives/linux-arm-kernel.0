From: gregkh@linuxfoundation.org (gregkh)
Date: Wed, 8 Mar 2017 09:42:09 +0100
Subject: next build: 208 builds: 21 failed, 187 passed, 53 errors, 406
 warnings (next-20170308)
In-Reply-To: <CAK8P3a16cpvK3_a0Rxx+XqRw_d97LtVgpzcpvpzmH6U4Ty-fXQ@mail.gmail.com>
References: <58bf7d43.8173190a.8d21e.1fde@mx.google.com>
 <CAK8P3a16cpvK3_a0Rxx+XqRw_d97LtVgpzcpvpzmH6U4Ty-fXQ@mail.gmail.com>
Message-ID: <20170308084209.GA16755@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 08, 2017 at 09:24:01AM +0100, Arnd Bergmann wrote:
> On Wed, Mar 8, 2017 at 4:40 AM, kernelci.org bot <bot@kernelci.org> wrote:
> > cavium_octeon_defconfig (mips) ? FAIL, 4 errors, 4 warnings, 0 section
> > mismatches
> > Warnings:
> > drivers/staging/octeon/ethernet-rx.c:339:28: warning: unused variable 'priv'
> > [-Wunused-variable]
> 
> I sent the patch on Feb 17, resent the same one today

Oops, I have 400+ staging patches to dig through, will get to that one
soon, sorry about it.

greg k-h
