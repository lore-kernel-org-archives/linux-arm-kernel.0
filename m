From: will.deacon@arm.com (Will Deacon)
Date: Wed, 04 May 2011 18:01:42 +0100
Subject: [PATCHv2 4/4] ARM: tegra: irq: Add tegra_eoi
In-Reply-To: <BANLkTi=a26_A7yAAfkQd5NSxbR+reQCZ1g@mail.gmail.com>
References: <1304284213-11950-5-git-send-email-ccross@android.com>
	<1304288854-11011-1-git-send-email-ccross@android.com>
	<1304414973.27863.2.camel@e102144-lin.cambridge.arm.com>
	<BANLkTi=a26_A7yAAfkQd5NSxbR+reQCZ1g@mail.gmail.com>
Message-ID: <1304528502.1935.2.camel@craptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-05-03 at 19:41 +0100, Colin Cross wrote:
> What is your plan for merging the fasteoi patches?  If you are
> planning to put them in 2.6.40, can you pull these patches into your
> tree?  I don't have any other Tegra changes planned for 2.6.40, so
> they shouldn't cause conflicts later.

Ok, since Santosh would like me to take his relaxed I/O stuff for the
GIC too then I guess I can put all of this into an irq branch along with
the fasteoi changes.

Russell - would you be happy pulling this from me if I put it together?

Cheers,

Will
