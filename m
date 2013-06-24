From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Jun 2013 09:54:27 +0100
Subject: [PATCH 0/5] Kernel mode NEON for XOR and RAID6
In-Reply-To: <CAKv+Gu-jeHfJ1Ai63NVwY=x4PTfg+w_SnhzF4Sxs2+Xk+PpsoQ@mail.gmail.com>
References: <1370530985-20619-1-git-send-email-ard.biesheuvel@linaro.org>
 <20130606151705.GG16794@mudshark.cambridge.arm.com>
 <alpine.LFD.2.03.1306061156330.18597@syhkavp.arg>
 <20130607175007.GH8111@mudshark.cambridge.arm.com>
 <alpine.LFD.2.03.1306072214120.18597@syhkavp.arg>
 <20130621093311.GD6983@mudshark.cambridge.arm.com>
 <CAKv+Gu8FTXC9XSE4DJ2LQueJ3FKjdjv8=sjDjTETH7fq+ruNGQ@mail.gmail.com>
 <51C46A0D.8070505@codeaurora.org>
 <CAKv+Gu-jeHfJ1Ai63NVwY=x4PTfg+w_SnhzF4Sxs2+Xk+PpsoQ@mail.gmail.com>
Message-ID: <20130624085427.GY2718@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 24, 2013 at 10:08:10AM +0200, Ard Biesheuvel wrote:
> On 21 June 2013 16:58, Christopher Covington <cov@codeaurora.org> wrote:
> > Hi Ard,
> >
> > If this is indeed the consensus (I don't disagree with any of it myself),
> > perhaps committing the main points, guidelines, and examples to
> > Documentation/arm/* would be useful.
> >
> 
> Hello Chris,
> 
> I agree that it makes sense to document any guidelines we set
> regarding the use of NEON in kernel mode, and I will happily do so.
> However, let's first try to wrap up this discussion, haven't heard
> back from Russell yet on his current position in this matter.

I think it's probably fine now - you have ample justification, and you
seem to be ensuring that things are done safely.

The only thing I'm left wondering about is whether the bits outside
arch/arm should go to anyone else, but MAINTAINERS is being unhelpful
on that - so I'm tempted to say that if someone should've been copied
who hasn't, and they're not in MAINTAINERS that's their problem.
