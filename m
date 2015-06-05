From: bp@alien8.de (Borislav Petkov)
Date: Fri, 5 Jun 2015 11:17:31 +0200
Subject: [PATCHv2 2/4] edac, altera: Refactor EDAC for Altera CycloneV SoC.
In-Reply-To: <5570D0D0.9030803@opensource.altera.com>
References: <1433428128-7292-1-git-send-email-tthayer@opensource.altera.com>
 <1433428128-7292-3-git-send-email-tthayer@opensource.altera.com>
 <55706E25.8050105@opensource.altera.com>
 <5570C479.7010902@opensource.altera.com>
 <20150604220609.GK3795@pd.tnic>
 <5570D0D0.9030803@opensource.altera.com>
Message-ID: <20150605091731.GA3679@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 04, 2015 at 05:27:28PM -0500, Dinh Nguyen wrote:
> This is my mistake. I applied Alan Tull's patch for suspend-to-ram which
> also touches drivers/edac/altera_edac.c.
> 
> https://git.kernel.org/cgit/linux/kernel/git/dinguyen/linux.git/commit/?h=socfpga_for_next_arria10&id=d44a92eb044f4cc1abf34a790d647e9fa356d7b0
> 
> I think I will have to ask Alan to split up his patch and send the part
> that touches altera_edac.c to linux-edac.

Nah, that's fine. If it is that hunk adding altr_sdram_prepare(), he can
simply add my ACK for the EDAC bits:

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
