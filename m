From: macro@mips.com (Maciej W. Rozycki)
Date: Wed, 11 Apr 2018 18:04:33 +0100
Subject: [PATCH v3 2/2] MIPS: io: add a barrier after register read in
 readX()
In-Reply-To: <20180406212601.GA1730@saruman>
References: <1522760109-16497-1-git-send-email-okaya@codeaurora.org>
 <1522760109-16497-2-git-send-email-okaya@codeaurora.org>
 <41e184ae-689e-93c9-7b15-0c68bd624130@codeaurora.org>
 <b748fdcb-e09f-9fe3-dc74-30b6a7d40cbe@codeaurora.org>
 <20180406212601.GA1730@saruman>
Message-ID: <alpine.DEB.2.00.1804111756420.1545@tp.orcam.me.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

> > Any news on the MIPS front? Is this something that Arnd can merge? or does it have
> > to go through the MIPS tree.
> 
> It needs some MIPS input really. I'll try and take a look soon. Thanks
> for the nudge.
> 
> > It feels like the MIPS is dead since nobody replied to me in the last few weeks on
> > a very important topic.
> 
> Not dead, just both maintainers heavily distracted by real life right
> now (which sadly, for me at least, trumps this very important topic) and
> doing the best they can given the circumstances.

 Can I help move this change forward anyhow?

  Maciej
