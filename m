From: sergey.senozhatsky@gmail.com (Sergey Senozhatsky)
Date: Sat, 20 May 2017 18:04:51 +0900
Subject: [PATCH v2] printk: Use the main logbuf in NMI when logbuf_lock
 is available
In-Reply-To: <20170519130223.GB12489@pathway.suse.cz>
References: <1493912763-24873-1-git-send-email-pmladek@suse.com>
 <20170519025803.GA593@jagdpanzerIV.localdomain>
 <20170519043815.GB593@jagdpanzerIV.localdomain>
 <20170519130223.GB12489@pathway.suse.cz>
Message-ID: <20170520090451.GA406@tigerII.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On (05/19/17 15:02), Petr Mladek wrote:
> > [..]
> > 
> > > the problem is that
> > > 
> > > 	`PRINTK_NMI_CONTEXT_MASK || PRINTK_NMI_DEFERRED_CONTEXT_MASK' is 0x01
> > 
> > d'oh... forgot to copy-paste this...
> 
> Grrr, thanks a lot for chasing this down and I am sorry for the troubles.

no worries :)


> I have rebased both for-4.13 and for-next branches in printk.git
> with this fix. I wanted to get rid of this bug in linux-next
> ASAP. Please, let me know if you would prefer to handle
> this another way in the future.

we are cool ;) thanks.

	-ss
