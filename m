From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Sep 2011 15:43:13 +0100
Subject: [PATCH] ARM: BUG() dies silently
In-Reply-To: <CAB-zwWi1K8y8fHzy0hgcFPgSfhMrZNfoKQ9xuU00Y1sLg6ZBmw@mail.gmail.com>
References: <1301602523-9906-1-git-send-email-omar.ramirez@ti.com>
	<CAH+eYFBSiL44CMOpgED+TAOTUH_dQMaKKu=hC3ynG0Y2nQ8ekw@mail.gmail.com>
	<CAB-zwWi1K8y8fHzy0hgcFPgSfhMrZNfoKQ9xuU00Y1sLg6ZBmw@mail.gmail.com>
Message-ID: <20110919144313.GU16381@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2011 at 09:26:49AM -0500, Ramirez Luna, Omar wrote:
> Hi
> 
> On Sat, Sep 17, 2011 at 1:07 AM, Rabin Vincent <rabin@rab.in> wrote:
> > If the "Use generic BUG() handler" patch is only scheduled for the next
> > merge window and not for 3.1, can this patch be merged instead for 3.1
> > and -stable? ?This problem is easily seen with GCC 4.6.
> 
> I can send it for both and let the maintainers decide.
> 
> Russell, do you give your ack?

I think it's too large a change for -stable and 3.1 - let's get it into
3.2 first, and make sure no one sees any regressions there.  Then we can
think about submitting it to stable once its proven itself.
