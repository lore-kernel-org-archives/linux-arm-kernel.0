From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 10 Dec 2013 08:50:07 +0000
Subject: [PATCH v2 01/15] mfd: menelaus: Drop __exit section annotation
In-Reply-To: <20131209161422.GC24047@saruman.home>
References: <1386042188-12246-1-git-send-email-balbi@ti.com>
 <20131203095136.GF11828@lee--X1>
 <20131208190739.GA18977@saruman.home>
 <20131209093748.GA12675@lee--X1>
 <20131209161422.GC24047@saruman.home>
Message-ID: <20131210085007.GO12675@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > > The code looks mostly fine, but the implementation of the commit logs
> > > > seems lazy. Please submit a v3 using coherent sentences with full
> > > > explanations and correct punctuation.
> > > 
> > > example ?
> > 
> > All of your commit messages.
> > 
> > > that macro just helps removing some extra
> > 
> >   ^- Sentences start with an uppercase character.
> > 
> > > line of code and hides ffs() calls.
> > > 
> > > while at that, also fix a variable shadowing
> > 
> >   ^- Sentences start with an uppercase character.
> > 
> > > bug where 'int irq' was being redeclared inside
> > > inner loop while it was also argument to interrupt
> > > handler.
> > 
> >   < ---------------   50 chars   ----------------- >
> > 
> > Please use the full 72 char (or there abouts) width of the buffer.
> 
> I don't see any mention of punctuation problems, however. Also, you're
> not complaining about the content at all, which tells me those sentences
> aren't as incoherent as you claimed before.

I didn't read them in any detail. I traversed through the patches and
saw that the formatting looked obscure on all of them. As I have come
to expect more of your submissions, I provided a generic reply
detailing how I expected the commit logs to be. I wasn't insinuated
that you failed to meet all of the criteria, but they definitely fell
short of the mark.

> But fair enough, I'll fix those up and add Aaro's Tested-by

Thank you.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
