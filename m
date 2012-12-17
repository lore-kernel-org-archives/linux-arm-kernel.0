From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Dec 2012 15:46:02 +0000
Subject: [QUESTION] mmc: mmci: Howto merge patches
In-Reply-To: <CAPDyKFpXyVCzFWkyL3+92Zb9hoyKaEV4hpaUYO9O5o71nNmk8w@mail.gmail.com>
References: <CAPDyKFpXyVCzFWkyL3+92Zb9hoyKaEV4hpaUYO9O5o71nNmk8w@mail.gmail.com>
Message-ID: <20121217154602.GT14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 17, 2012 at 04:29:51PM +0100, Ulf Hansson wrote:
> Hi Russell and Chris,
> 
> I would like to propose a change of how we handle mmci patches to be
> merged. Instead of going through Russell's arm tree, I would like
> Chris to handle the merge through his mmc tree.
> 
> The reason is simply that patches can have dependencies to the
> protocol layer and in seems a bit unnecessary to wait for another
> merge window to occur to handle these patches.

You're going to have to wait another merge window _anyway_ because no
kernel developer should be stuffing their tree full of patches during
any merge window that have not already been in linux-next well _before_
the merge window.

So like it or not, this merge window already closed to new submissions
maybe two weeks ago.

> Moreover, if most of the mmci patches goes through Chris mmc tree, I
> believe we would minimize the number of possible conflicts. Russell
> will then only need to NACK patches to prevent them from being merged.
> 
> Do you think this could be and acceptable setup for both of you?

The reason that you want to do this is because you're realising that it's
taking a long time for you to get your patches into mainline.  The reason
that I'm being slow with your patches is that you haven't built up the
trust on my side that I can simply say "yes that's fine, I trust your
patches."

That alone is good enough reason for me to say no way to this.
