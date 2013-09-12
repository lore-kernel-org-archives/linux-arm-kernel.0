From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 11 Sep 2013 18:50:02 -0700
Subject: [PATCH] ARM: kvm: rename cpu_reset to avoid name clash
In-Reply-To: <CAOesGMjum0TSyudXiZtXHOGX4R7dBAhjUpoYnwjTcfD1MMpTxw@mail.gmail.com>
References: <1378938461-10835-1-git-send-email-olof@lixom.net>
 <CAOesGMjum0TSyudXiZtXHOGX4R7dBAhjUpoYnwjTcfD1MMpTxw@mail.gmail.com>
Message-ID: <20130912015002.GO9860@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 11, 2013 at 03:39:26PM -0700, Olof Johansson wrote:
> On Wed, Sep 11, 2013 at 3:27 PM, Olof Johansson <olof@lixom.net> wrote:
> > cpu_reset is already #defined in <asm/proc-fns.h> as processor.reset,
> > so it expands here and causes problems.
> >
> > Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> I just noticed this is broken on 3.10 too, so if/when applying feel free to add:
> 
> Cc: <stable@vger.kernel.org> # 3.10+
> 
Thanks for the fix, applied.

-Christoffer
