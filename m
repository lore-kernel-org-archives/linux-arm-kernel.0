From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Thu, 4 Jun 2015 17:27:28 -0500
Subject: [PATCHv2 2/4] edac, altera: Refactor EDAC for Altera CycloneV SoC.
In-Reply-To: <20150604220609.GK3795@pd.tnic>
References: <1433428128-7292-1-git-send-email-tthayer@opensource.altera.com>
 <1433428128-7292-3-git-send-email-tthayer@opensource.altera.com>
 <55706E25.8050105@opensource.altera.com>
 <5570C479.7010902@opensource.altera.com> <20150604220609.GK3795@pd.tnic>
Message-ID: <5570D0D0.9030803@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/2015 05:06 PM, Borislav Petkov wrote:
> On Thu, Jun 04, 2015 at 04:34:49PM -0500, Thor Thayer wrote:
>> OK. I'll refactor and resend. I was using Altera's internal for-next branch.
> 
> Use this one:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git#for-next
> 

This is my mistake. I applied Alan Tull's patch for suspend-to-ram which
also touches drivers/edac/altera_edac.c.

https://git.kernel.org/cgit/linux/kernel/git/dinguyen/linux.git/commit/?h=socfpga_for_next_arria10&id=d44a92eb044f4cc1abf34a790d647e9fa356d7b0

I think I will have to ask Alan to split up his patch and send the part
that touches altera_edac.c to linux-edac.

Sorry about the confusion.

Dinh
