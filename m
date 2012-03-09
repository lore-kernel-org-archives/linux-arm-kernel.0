From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 9 Mar 2012 12:40:02 +0100
Subject: [PULL] of nand generic binding
In-Reply-To: <20120309014439.235C23E0901@localhost>
References: <20120217155707.GR1214@game.jcrosoft.org>
 <20120229152534.GH3318@game.jcrosoft.org>
 <20120307082945.GJ21255@game.jcrosoft.org>
 <4F576602.8020808@gmail.com> <20120309014439.235C23E0901@localhost>
Message-ID: <20120309114002.GP27213@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18:44 Thu 08 Mar     , Grant Likely wrote:
> On Wed, 07 Mar 2012 07:43:30 -0600, Rob Herring <robherring2@gmail.com> wrote:
> > On 03/07/2012 02:29 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > On 16:25 Wed 29 Feb     , Jean-Christophe PLAGNIOL-VILLARD wrote:
> > >> On 16:57 Fri 17 Feb     , Jean-Christophe PLAGNIOL-VILLARD wrote:
> > >>> HI,
> > >>>
> > >>> 	please find attached the generic binding for the MTD nand
> > >>>
> > >>> 	This will add boolean and nand helpers
> > >> is it ok?
> > > I need this for 3.4
> > > 
> > > will you apply it or can I apply it via AT91
> > 
> > Looks fine to me and Grant acked it, so go ahead and take with your at91
> > branch.
> 
> Actually, taking another look at the of_mtd patch, that stuff really
> belongs in the drivers/mtd directory.  I'm not nacking the patch, but
> you should send a follow up to move it into the correct place.
ok

Best Regards,
J.
