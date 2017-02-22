From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Wed, 22 Feb 2017 15:58:49 +0000
Subject: [BUGFIX PATCH V2 0/3] kprobes/arm: Improve kprobes
 implementation on arm
In-Reply-To: <20170218064352.b1685bbd17c0189b1937ce3b@kernel.org>
References: <148711844284.5814.10387227824715177703.stgit@devbox>
 <1487329270.3113.5.camel@linaro.org>
 <20170218064352.b1685bbd17c0189b1937ce3b@kernel.org>
Message-ID: <1487779129.18810.10.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2017-02-18 at 06:43 +0900, Masami Hiramatsu wrote:
> On Fri, 17 Feb 2017 11:01:10 +0000
> "Jon Medhurst (Tixy)" <tixy@linaro.org> wrote:
[...]
> > Meantime
> > I'll investigate the kprobes test failures I see (which actually looks
> > like cache/TLB issues and not test code problems after all).
> 
> OK, btw, I couldn't reproduce the kprobes test failure with
> CONFIG_DEBUG_RODATA=y on qemu...

That's because it's a problem with caches which qemu doesn't emulate.
I worked out the cause and posted a patch...
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-February/489517.html

-- 
Tixy
