From: bp@alien8.de (Borislav Petkov)
Date: Wed, 12 Aug 2015 12:49:54 +0200
Subject: [PATCH v3 1/4] edac: Add an function to retrieve the EDAC
 debugfs node
In-Reply-To: <20150812101219.GC14011@nazgul.tnic>
References: <1439326077-25507-1-git-send-email-lho@apm.com>
 <1439326077-25507-2-git-send-email-lho@apm.com>
 <20150812101219.GC14011@nazgul.tnic>
Message-ID: <20150812104954.GD14011@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 12:12:19PM +0200, Borislav Petkov wrote:
> EXPORT_SYMBOL_GPL() if it is going to be used by modules.

Better yet, move it to the header.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
