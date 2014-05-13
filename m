From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 13 May 2014 16:49:39 +0200
Subject: [GIT PULL] Allwinner Pinctrl changes for 3.16
In-Reply-To: <CACRpkdZUJrCdyLJdnZw64=rrbOvyHs9nVEmZ=D7ke1hF_n2_Fg@mail.gmail.com>
References: <20140508225209.GA13610@lukather>
 <CACRpkda7QT+sGs6wY6-fbcZ3k4sXfP=rmPimfqHjbUB5vQuO5A@mail.gmail.com>
 <20140509173156.GF7047@lukather>
 <CACRpkdae=i8C49AMJCrRe0a=4d8Y+FhkiEOv=EJ_NfakYqRvzg@mail.gmail.com>
 <20140512152520.GD17154@lukather>
 <CACRpkdZUJrCdyLJdnZw64=rrbOvyHs9nVEmZ=D7ke1hF_n2_Fg@mail.gmail.com>
Message-ID: <20140513144939.GC29258@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 13, 2014 at 11:37:15AM +0200, Linus Walleij wrote:
> On Mon, May 12, 2014 at 5:25 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Mon, May 12, 2014 at 11:22:27AM +0200, Linus Walleij wrote:
> 
> >> Also: why do you need it? Just as a dependence to dts files
> >> does *not* count as a reason to cross merge these trees,
> >> as the device tree files are meant to even be moved out of
> >> the kernel at some point... but you may have better reasons?
> >
> > It's not about DT, it's about the patch to select the pinctrl drivers
> > in the machine's Kconfig options.
> 
> But ... surely you can select a non-existant symbol and wait
> for it to appear during the merge window?
> 
> Or is there some problem with this?

Because it wouldn't be very easily bisectable.

After discussing this a bit more with Arnd on IRC, I'll send you an
additional patch for you to merge, that should solve the issue,
without requiring any merge on my side.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140513/50aa3dee/attachment-0001.sig>
