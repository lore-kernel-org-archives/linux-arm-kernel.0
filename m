From: bp@alien8.de (Borislav Petkov)
Date: Thu, 30 Oct 2014 16:22:40 +0100
Subject: [PATCHv2 0/4] Add Altera peripheral memories to EDAC framework
In-Reply-To: <544ECBB1.2040600@opensource.altera.com>
References: <1413578029-13205-1-git-send-email-tthayer@opensource.altera.com>
 <544E93F0.3030409@opensource.altera.com>
 <20141027204307.GB4741@pd.tnic>
 <544EBA84.7080109@opensource.altera.com>
 <20141027215908.GC4741@pd.tnic>
 <544ECBB1.2040600@opensource.altera.com>
Message-ID: <20141030152240.GD11178@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 27, 2014 at 05:48:17PM -0500, Thor Thayer wrote:
> Would the L2 cache and OCRAM specific functions also be in altera_edac.c?
> Each of these EDAC pieces is independent and can be compiled in without the
> others. I've read that the use of #ifdef's is discouraged and having
> separate files in the Makefile solves that.

Let's keep it simple and put all the altera bits in one file for now. If
we need to split some of the functionality out, we can always do that
later.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
