From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Tue, 5 Apr 2016 13:37:49 -0500
Subject: [PATCHv2 6/7] ARM: socfpga: Enable Arria10 OCRAM ECC on
 startup
In-Reply-To: <20160405053110.GA17541@pd.tnic>
References: <1459450087-24792-1-git-send-email-tthayer@opensource.altera.com>
 <1459450087-24792-7-git-send-email-tthayer@opensource.altera.com>
 <57034C4D.9010204@opensource.altera.com> <20160405053110.GA17541@pd.tnic>
Message-ID: <alpine.DEB.2.02.1604051333070.32718@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 5 Apr 2016, Borislav Petkov wrote:

> On Tue, Apr 05, 2016 at 12:25:33AM -0500, Thor Thayer wrote:
> > I realize that I'm not calling iounmap(ecc_block_base) and I'll fix that in
> > the next revision with a goto.
> 
> I'm assuming nothing else changes. Because I've applied 1-4 already.
> 
> Yes, no?
> 
> If no, then please send only an updated version of this patch as a reply
> to this thread here.
> 

My only suggestion was to change the 3 helper functions(ecc_set_bits,
ecc_clear_bits, and ecc_test_bits) should be static inline.

So with that change:

Acked-by: Dinh Nguyen <dinguyen@opensource.altera.com>

BR,
Dinh
