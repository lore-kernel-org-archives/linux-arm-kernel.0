From: bp@alien8.de (Borislav Petkov)
Date: Mon, 27 Oct 2014 21:43:07 +0100
Subject: [PATCHv2 0/4] Add Altera peripheral memories to EDAC framework
In-Reply-To: <544E93F0.3030409@opensource.altera.com>
References: <1413578029-13205-1-git-send-email-tthayer@opensource.altera.com>
 <544E93F0.3030409@opensource.altera.com>
Message-ID: <20141027204307.GB4741@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 27, 2014 at 01:50:24PM -0500, Thor Thayer wrote:
> Do you have any comments about this driver?

Just a question: why do you have three .c files for something which
does only error injection and nothing else AFAICT? Why isn't this part
of altera_edac.c?

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
