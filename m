From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 1 Dec 2015 10:18:48 +0100
Subject: [PATCH v3 01/10] arm64: Fold proc-macros.S into assembler.h
In-Reply-To: <1448559168-8363-2-git-send-email-james.morse@arm.com>
References: <1448559168-8363-1-git-send-email-james.morse@arm.com>
 <1448559168-8363-2-git-send-email-james.morse@arm.com>
Message-ID: <20151201091848.GA21222@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2015-11-26 17:32:39, James Morse wrote:
> From: Geoff Levand <geoff@infradead.org>
> 
> To allow the assembler macros defined in arch/arm64/mm/proc-macros.S to be used
> outside the mm code move the contents of proc-macros.S to asm/assembler.h.  Also,
> delete proc-macros.S, and fix up all references to proc-macros.S.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> Signed-off-by: James Morse <james.morse@arm.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
