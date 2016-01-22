From: bp@alien8.de (Borislav Petkov)
Date: Fri, 22 Jan 2016 19:08:30 +0100
Subject: [PATCHv8 1/4] EDAC, altera: Add Altera L2 Cache and OCRAM EDAC
 Support
In-Reply-To: <56A25F59.5070306@mentor.com>
References: <1453397668-32094-1-git-send-email-tthayer@opensource.altera.com>
 <56A1C5DE.1080501@mentor.com>
 <56A24C34.3000303@opensource.altera.com>
 <56A25F59.5070306@mentor.com>
Message-ID: <20160122180830.GH9806@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 22, 2016 at 06:56:57PM +0200, Vladimir Zapolskiy wrote:
> it sounds like the author of the original change is Dinh, but if you agreed
> about authorship transfer, then "From: Thor Thayer" statement should be
> correct, but in any case your SoB should follow Dinh's SoB, if you decide to
> keep the latter one.
> 
> This consideration may apply to the other changes in the changeset as well.

So the patch author should be in the From:

If Thor has changed the original patch considerably, then you Thor and
Dinh could decide amongst each other who should be the author.

If Thor becomes the author and lands in From:, then the commit message
could state something like "based on original work from Dinh" or
"Originally-from: Dinh" and so on. "git log" has some examples.

The SOB chain shows who handled the patch on its way upstream. So in
this case, it should be:

SOB: Dinh (if From: is Dinh - otherwise Originally-by:)
SOB: Thor
SOB: Boris

if I'm going to pick it up and send it to Linus.

Ok?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
