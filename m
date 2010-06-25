From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 25 Jun 2010 21:20:02 +0100
Subject: [PATCH v2 1/3] OMAP: PM: initial runtime PM core support
In-Reply-To: <AANLkTikYE6Kg8C_ZClx9aKLvOa9CQRUT587hQnB91sua@mail.gmail.com>
References: <1277422991-25350-1-git-send-email-khilman@deeprootsystems.com>
	<1277422991-25350-2-git-send-email-khilman@deeprootsystems.com>
	<AANLkTim4p54brsmph6oaKfoEZwO1GOGfgRNV9vJykOjl@mail.gmail.com>
	<20100625200659.GB22090@n2100.arm.linux.org.uk>
	<AANLkTikYE6Kg8C_ZClx9aKLvOa9CQRUT587hQnB91sua@mail.gmail.com>
Message-ID: <20100625202002.GC22090@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 25, 2010 at 02:13:15PM -0600, Grant Likely wrote:
> On Fri, Jun 25, 2010 at 2:06 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Fri, Jun 25, 2010 at 09:26:43AM -0600, Grant Likely wrote:
> >> This approach is also not multiplatform friendly (cc'ing Eric and
> >> Nicolas who are working on ARM multiplatform). ?It won't work for
> >> building a kernel that supports, say, both versatile and OMAP.
> >
> > And I should also point out that multiplatform is not the answer to
> > Linus' concerns. ?There's no way such work is going to be anywhere
> > near complete come the next merge window.
> 
> Yes, but solving the defconfig problem isn't the reason for multiplatform.

Does anyone know where we are on the defconfig problem?  From what I
can see, it's mostly stalled for the time being, which is not good
news for us.
