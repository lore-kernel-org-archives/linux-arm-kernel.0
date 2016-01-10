From: bp@alien8.de (Borislav Petkov)
Date: Sun, 10 Jan 2016 12:08:14 +0100
Subject: [PATCH v3 0/2] acpi: apei: Bug fix to enable APEI support for
 ARMv8
In-Reply-To: <CAPw-ZT=Kor1E7NpAkoAyJtULiCGuCCsoSES05Dr6-eUUS8dDHg@mail.gmail.com>
References: <1446857519-5908-1-git-send-email-lho@apm.com>
 <CAPw-ZT=Kor1E7NpAkoAyJtULiCGuCCsoSES05Dr6-eUUS8dDHg@mail.gmail.com>
Message-ID: <20160110110813.GB22896@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2016 at 04:30:48PM -0800, Loc Ho wrote:
> It has been awhile and I thought I check again on this. Any issue with
> these two changes as it is needed for ARMv8 64-bit APEI support.
> Without these two changes, APEI support will NOT work with X-Gene
> platforms.

Patch 1 could be improved. It is Rafael's call in the end of the day.

Patch 2 looks ok to me.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
