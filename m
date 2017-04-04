From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Tue, 04 Apr 2017 17:01:43 +0100
Subject: [PATCH v3] arm: Fix memory attribute inconsistencies when using
 fixmap
In-Reply-To: <CAKv+Gu-0WU_XzLfGyf5qhkmyrxs+yCG8ot1YFrbL0A7xO1Z_0g@mail.gmail.com>
References: <1491291087-17450-1-git-send-email-ard.biesheuvel@linaro.org>
 <1491295730.2995.1.camel@linaro.org>
 <CAKv+Gu-0WU_XzLfGyf5qhkmyrxs+yCG8ot1YFrbL0A7xO1Z_0g@mail.gmail.com>
Message-ID: <1491321703.2995.18.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-04-04 at 10:10 +0100, Ard Biesheuvel wrote:
> On 4 April 2017 at 09:48, Jon Medhurst (Tixy) <tixy@linaro.org> wrote:
[...]
> > I tested this change with kprobes tests on TC2 (the setup that showed
> > the original bug) and compile tested for a nommu device (I will boot
> > test that in a bit as that's not quick to setup).

The nommu device (ARM MPS2) boots OK

> > 
> > Also, with this patch we can now make early_paging_init() static now,
> > and remove the extern...

[...]

> Good point. If everything checks out, we should fold that in when
> submitting it to the patch tracker.

I delayed a little in case Russell had comments about the changes, but
I've now submitted the patch...
http://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8667/2

-- 
Tixy
