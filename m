From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 7 Jun 2013 10:08:22 +0100
Subject: [Arm-netbook] getting allwinner SoC support upstream (was Re:
 Uploading linux (3.9.4-1))
In-Reply-To: <51B19C85.9090407@gmail.com>
References: <CAPweEDx3mAy40BZrzrKPRbvg7vKMj7KevDQ3m_v4p6Yo50eSGg@mail.gmail.com>
 <1851164.HnXhGSdttW@flatron>
 <CAPweEDxWW4LUeBaHLb+wHuAMq=63p88zsx4tumVb2PdP_+ohAw@mail.gmail.com>
 <1622862.fXQWv0YWGV@flatron>
 <CAPweEDx_1fvAv9sROtPreoyyj_yDAuYb040fM2zPc+tf22d=YA@mail.gmail.com>
 <51B19C85.9090407@gmail.com>
Message-ID: <20130607090822.GS18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 10:40:37AM +0200, Vladimir Pantelic wrote:
> luke.leighton wrote:>   so.
> >
> >   coming back to what you said earlier: i'm formulating what to say to
> > allwinner [and need to pre-send something by monday so that they can
> > consider it before the meeting].  so far, it consists of:
> >
> > * device-tree is what the linux kernel community has come up with, it
> > is equivalent to FEX.
> >
> > * the linux kernel community would like to apologise for not
> > consulting with you (allwinner) on the decision to only accept device
> > tree
>
> apologize? WTF?

(I don't seem to have the original mail).

Definitely not.

The way this generally works is that discussions happen in public on
mailing lists, and people who have an interest get involved in the
discussion.  If someone decides to avoid the mailing lists because they
want to be secret about XYZ then they won't be part of the decision
making process - but that's not _our_ problem.  That is _their_ problem.

In the case of DT, there was quite a lengthy discussion about it and
its adoption.

So, either the discussion took place _before_ there was any interest in
the ARM kernel developments from Allwinner, or they themselves _chose_
not to be represented in the discussion by not being on the mailing list
or participating in the discussion.

There is nothing for us to apologise for here.

(Occasionally, the kernel community *is* a dictatorship - for example,
when Linus threatens to delete all the ARM defconfigs, or when Linus
decides that we're running out of control when adding more than 10k
lines of new code per kernel release, or - in the same way - when I see
something I really don't like, but thankfully those are fairly rare.)
