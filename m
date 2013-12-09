From: balbi@ti.com (Felipe Balbi)
Date: Mon, 9 Dec 2013 10:14:22 -0600
Subject: [PATCH v2 01/15] mfd: menelaus: Drop __exit section annotation
In-Reply-To: <20131209093748.GA12675@lee--X1>
References: <1386042188-12246-1-git-send-email-balbi@ti.com>
 <20131203095136.GF11828@lee--X1>
 <20131208190739.GA18977@saruman.home>
 <20131209093748.GA12675@lee--X1>
Message-ID: <20131209161422.GC24047@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 09, 2013 at 09:37:48AM +0000, Lee Jones wrote:
> > > The code looks mostly fine, but the implementation of the commit logs
> > > seems lazy. Please submit a v3 using coherent sentences with full
> > > explanations and correct punctuation.
> > 
> > example ?
> 
> All of your commit messages.
> 
> > that macro just helps removing some extra
> 
>   ^- Sentences start with an uppercase character.
> 
> > line of code and hides ffs() calls.
> > 
> > while at that, also fix a variable shadowing
> 
>   ^- Sentences start with an uppercase character.
> 
> > bug where 'int irq' was being redeclared inside
> > inner loop while it was also argument to interrupt
> > handler.
> 
>   < ---------------   50 chars   ----------------- >
> 
> Please use the full 72 char (or there abouts) width of the buffer.

I don't see any mention of punctuation problems, however. Also, you're
not complaining about the content at all, which tells me those sentences
aren't as incoherent as you claimed before. But fair enough, I'll fix
those up and add Aaro's Tested-by

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131209/3696edec/attachment.sig>
