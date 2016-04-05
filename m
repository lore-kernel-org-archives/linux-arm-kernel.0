From: bp@alien8.de (Borislav Petkov)
Date: Tue, 5 Apr 2016 07:31:10 +0200
Subject: [PATCHv2 6/7] ARM: socfpga: Enable Arria10 OCRAM ECC on startup
In-Reply-To: <57034C4D.9010204@opensource.altera.com>
References: <1459450087-24792-1-git-send-email-tthayer@opensource.altera.com>
 <1459450087-24792-7-git-send-email-tthayer@opensource.altera.com>
 <57034C4D.9010204@opensource.altera.com>
Message-ID: <20160405053110.GA17541@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 05, 2016 at 12:25:33AM -0500, Thor Thayer wrote:
> I realize that I'm not calling iounmap(ecc_block_base) and I'll fix that in
> the next revision with a goto.

I'm assuming nothing else changes. Because I've applied 1-4 already.

Yes, no?

If no, then please send only an updated version of this patch as a reply
to this thread here.

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
