From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Fri, 28 Nov 2014 11:17:36 +0000
Subject: [PATCH v10 2/2] ARM: kprobes: enable OPTPROBES for ARM 32
In-Reply-To: <20141128111327.GR3836@n2100.arm.linux.org.uk>
References: <1416551751-50846-1-git-send-email-wangnan0@huawei.com>
 <1416551751-50846-3-git-send-email-wangnan0@huawei.com>
 <1417099007.2041.6.camel@linaro.org> <5477E82A.3020208@hitachi.com>
 <1417169308.1845.1.camel@linaro.org>
 <20141128111327.GR3836@n2100.arm.linux.org.uk>
Message-ID: <1417173456.1845.3.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-11-28 at 11:13 +0000, Russell King - ARM Linux wrote:
> On Fri, Nov 28, 2014 at 10:08:28AM +0000, Jon Medhurst (Tixy) wrote:
> > On Fri, 2014-11-28 at 12:12 +0900, Masami Hiramatsu wrote:
> > > (2014/11/27 23:36), Jon Medhurst (Tixy) wrote:
> > [...]
> > > > I thought it good to see what sort of benefits this code achieves,
> > > > especially as it could grow quite complex over time, and the cost of
> > > > that versus the benefit should be considered.
> > > 
> > > I don't think it's so complex. It's actually cleanly separated.
> > > However, ARM tree should have arch/arm/kernel/kprobe/ dir,
> > > since there are too many kprobe related files under arch/arm/kernel/ ...
> > 
> > Yes, that does seem like a good idea. Or rather a 'probes' directory to
> > also include uprobes as that shares a lot of code with kprobes.
> 
> If you want to do this, then please make it arch/arm/probes rather than
> making the directory tree deeper than it needs to be.

Yes, good point.

-- 
Tixy
