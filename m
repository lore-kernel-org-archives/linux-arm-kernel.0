From: bp@alien8.de (Borislav Petkov)
Date: Tue, 5 Apr 2016 22:15:30 +0200
Subject: [PATCHv2 6/7] ARM: socfpga: Enable Arria10 OCRAM ECC on startup
In-Reply-To: <alpine.DEB.2.02.1604051333070.32718@linux-builds1>
References: <1459450087-24792-1-git-send-email-tthayer@opensource.altera.com>
 <1459450087-24792-7-git-send-email-tthayer@opensource.altera.com>
 <57034C4D.9010204@opensource.altera.com>
 <20160405053110.GA17541@pd.tnic>
 <alpine.DEB.2.02.1604051333070.32718@linux-builds1>
Message-ID: <20160405201530.GK17541@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 05, 2016 at 01:37:49PM -0500, Dinh Nguyen wrote:
> My only suggestion was to change the 3 helper functions(ecc_set_bits,
> ecc_clear_bits, and ecc_test_bits) should be static inline.

That doesn't take care of the iounmap error path Thor is talking about,
AFAICT.

So, I've pushed out what I have applied so far:

http://git.kernel.org/cgit/linux/kernel/git/bp/bp.git/log/?h=for-next

Thor, please send me what is outstanding ontop.

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
