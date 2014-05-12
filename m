From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 12 May 2014 17:25:20 +0200
Subject: [GIT PULL] Allwinner Pinctrl changes for 3.16
In-Reply-To: <CACRpkdae=i8C49AMJCrRe0a=4d8Y+FhkiEOv=EJ_NfakYqRvzg@mail.gmail.com>
References: <20140508225209.GA13610@lukather>
 <CACRpkda7QT+sGs6wY6-fbcZ3k4sXfP=rmPimfqHjbUB5vQuO5A@mail.gmail.com>
 <20140509173156.GF7047@lukather>
 <CACRpkdae=i8C49AMJCrRe0a=4d8Y+FhkiEOv=EJ_NfakYqRvzg@mail.gmail.com>
Message-ID: <20140512152520.GD17154@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 12, 2014 at 11:22:27AM +0200, Linus Walleij wrote:
> On Fri, May 9, 2014 at 7:31 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> 
> > Only pinctrl/next is not going to be rebased, right?
> 
> pinctrl/devel actually.
> 
> for-next is a mixdown branch that is rebased all the time
> so don't use that.

Ok.

> But notify me first if you're going to be pulling in that branch!
> (Handshake.)

Yes, this is exactly what I'm doing :)

> Also: why do you need it? Just as a dependence to dts files
> does *not* count as a reason to cross merge these trees,
> as the device tree files are meant to even be moved out of
> the kernel at some point... but you may have better reasons?

It's not about DT, it's about the patch to select the pinctrl drivers
in the machine's Kconfig options.

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
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140512/0f2f8d12/attachment.sig>
