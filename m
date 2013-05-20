From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 20 May 2013 23:42:14 +0100
Subject: [PATCH 04/20] ARM: picoxcell: Remove init_irq declaration in
 machine description
In-Reply-To: <519496AC.1070809@free-electrons.com>
References: <1368545933-7430-1-git-send-email-maxime.ripard@free-electrons.com>
 <1368545933-7430-5-git-send-email-maxime.ripard@free-electrons.com>
 <20130514162046.GA16346@page> <519496AC.1070809@free-electrons.com>
Message-ID: <20130520224214.GA4659@page>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 10:19:56AM +0200, Maxime Ripard wrote:
> Hi Jamie,
> 
> Le 14/05/2013 18:20, Jamie Iles a ?crit :
> > Hi Maxime,
> > 
> > Thanks for this, I'll add it to my tree.  I've modified it slightly to 
> > kill off the other irq includes, hopefully that's okay with you.
> 
> Yes, I was pretty conservative since I was not familiar with most of the
> code, but yes, I'm fine with the changes.

Thanks Maxime, applied to picoxcell-next.

Jamie
