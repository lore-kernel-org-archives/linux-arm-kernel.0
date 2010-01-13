From: gregkh@suse.de (Greg KH)
Date: Wed, 13 Jan 2010 07:33:29 -0800
Subject: Possible suspend/resume regression in .32-rc?
In-Reply-To: <1263390161.5419.9.camel@hammer.suse.cz>
References: <20091101205449.GT14091@buzzloop.caiaq.de>
	<20091101213343.GA31345@elf.ucw.cz>
	<20091101220341.GA16698@elf.ucw.cz>
	<771cded00911020122o3bb5cc96q957c8be1ce7cae46@mail.gmail.com>
	<1257155873.5642.14.camel@utx.utx.cz>
	<771cded00911021931x41cfa51bh2959d3748db5ac0@mail.gmail.com>
	<1257241821.4269.5.camel@utx.utx.cz>
	<771cded00911042106u39fd3655mae50a89bd419411b@mail.gmail.com>
	<20100113114651.GJ8970@buzzloop.caiaq.de>
	<1263390161.5419.9.camel@hammer.suse.cz>
Message-ID: <20100113153329.GA1276@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 13, 2010 at 02:42:41PM +0100, Stanislav Brabec wrote:
> Daniel Mack wrote:
> 
> > It seems Stanislav's patch is still unmerged in the current git HEAD.
> > Any idea why it is held back? I have it applied locally since quite a
> > while here, and it works well. So if it helps, take my Tested-by: for
> > it.
> 
> It seems to be on the right way:
> 
> From: gregkh at suse.de
> Subject: patch serial-core-resume-serial-hardware-with-no_console_suspend.patch added to gregkh-2.6 tree
> Date: Tue, 22 Dec 2009 12:22:35 -0800
> 
> This is a note to let you know that I've just added the patch titled
> 
>     Subject: serial-core: resume serial hardware with no_console_suspend
> 
> to my gregkh-2.6 tree.  Its filename is
> 
>     serial-core-resume-serial-hardware-with-no_console_suspend.patch
> 
> This tree can be found at 
> 
> http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/

Ah, I missed that this was fixing a regression, so I'll move it to my
"apply before .32 is out" queue.  Sorry about that.

greg k-h
