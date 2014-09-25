From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 25 Sep 2014 16:44:04 +0100
Subject: [PATCH resend] arm:extend the reserved memory for initrd to be
 page aligned
In-Reply-To: <20140925143142.GF5182@n2100.arm.linux.org.uk>
References: <35FD53F367049845BC99AC72306C23D103D6DB49161F@CNBJMBX05.corpusers.net>
 <20140919095959.GA2295@e104818-lin.cambridge.arm.com>
 <20140925143142.GF5182@n2100.arm.linux.org.uk>
Message-ID: <20140925154403.GL10390@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 03:31:42PM +0100, Russell King - ARM Linux wrote:
> On Fri, Sep 19, 2014 at 11:00:02AM +0100, Catalin Marinas wrote:
> > On Fri, Sep 19, 2014 at 08:09:47AM +0100, Wang, Yalin wrote:
> > > this patch extend the start and end address of initrd to be page aligned,
> > > so that we can free all memory including the un-page aligned head or tail
> > > page of initrd, if the start or end address of initrd are not page
> > > aligned, the page can't be freed by free_initrd_mem() function.
> > > 
> > > Signed-off-by: Yalin Wang <yalin.wang@sonymobile.com>
> > 
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > 
> > (as I said, if Russell doesn't have any objections please send the patch
> > to his patch system)
> 
> I now have an objection.  The patches in the emails were properly formatted.

They were so close ;)

I can see three patches but none of them exactly right:

8157/1 - wrong diff format
8159/1 - correct format, does not have my ack (you can take this one if
	 you want)
8162/1 - got my ack this time but with the wrong diff format again

Maybe a pull request is a better idea.

-- 
Catalin
