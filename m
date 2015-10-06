From: bp@alien8.de (Borislav Petkov)
Date: Tue, 6 Oct 2015 13:31:33 +0200
Subject: [PATCH RFC] apei: xgene: Add ACPI APEI support for X-Gene
In-Reply-To: <CAPw-ZTn5stnEobMH018oLPn3nDO1uweVeVs=Otg3-6cXBWLz6g@mail.gmail.com>
References: <1443747112-24814-1-git-send-email-lho@apm.com>
 <20151002075411.GB16538@pd.tnic>
 <CAPw-ZTn5stnEobMH018oLPn3nDO1uweVeVs=Otg3-6cXBWLz6g@mail.gmail.com>
Message-ID: <20151006113133.GA28484@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 05, 2015 at 01:41:58PM -0700, Loc Ho wrote:
> Yes... We can make this generic. The only non-generic is the way the
> interrupt is cleared. As of right now, the method of clearing the
> interrupt is by writing back the same value as read. This would be
> fine for most.

Fine for most what? APM hardware, other hw?

> But to ensure 100% coverage, would an AML method be better or needed?

No idea, I'm not an ACPI guy. You probably should get in touch with the
people working on the ARM64 APEI driver and hash that out with them.

HTH.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
