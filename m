From: bp@alien8.de (Borislav Petkov)
Date: Thu, 13 Aug 2015 05:38:37 +0200
Subject: [PATCH v3 1/4] edac: Add an function to retrieve the EDAC
 debugfs node
In-Reply-To: <CAPw-ZT=AFtyLt4CNGBzLZcdPr-ekJpQxKA4Y_AiDzqKfhF1-=w@mail.gmail.com>
References: <1439326077-25507-1-git-send-email-lho@apm.com>
 <1439326077-25507-2-git-send-email-lho@apm.com>
 <20150812101219.GC14011@nazgul.tnic>
 <20150812104954.GD14011@nazgul.tnic>
 <CAPw-ZT=AFtyLt4CNGBzLZcdPr-ekJpQxKA4Y_AiDzqKfhF1-=w@mail.gmail.com>
Message-ID: <20150813033837.GC14432@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 10:23:11AM -0700, Loc Ho wrote:
> I can't move it completely to the header and make it static. It will
> generate a lot of compiler warning as it isn't used by other modules.

Come again?

I'm talking about static inline functions in headers. Grep the kernel
sources for examples.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
