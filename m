From: samitolvanen@google.com (Sami Tolvanen)
Date: Thu, 16 Nov 2017 15:50:19 -0800
Subject: [PATCH v2 08/18] arm64: don't disable ADR_PREL_PG_HI21* with
 ARM64_ERRATUM_843419
In-Reply-To: <CAKv+Gu9pROJ_T5twJtVn2itzav4x5fypyJWsBr5YbjWUTMFokg@mail.gmail.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171115213428.22559-9-samitolvanen@google.com>
 <CAKv+Gu-wYwBMV7tdb+Kax_cyPsmAB2R2ZVwJuNi9qM0kaYAs=Q@mail.gmail.com>
 <20171116114406.GB9361@arm.com>
 <20171116163132.GC94341@samitolvanen.mtv.corp.google.com>
 <CAKv+Gu8yPSwZep-S_ke_P5BiZ3o72R=ykhixoXcyGUHa1ZxGGw@mail.gmail.com>
 <20171116213702.GA10616@samitolvanen.mtv.corp.google.com>
 <CAKv+Gu_3R4SUC2hCUtEX_4ut9admtrBZS-S-mzQnQsoJoHPcBw@mail.gmail.com>
 <20171116230939.GA38360@samitolvanen.mtv.corp.google.com>
 <CAKv+Gu9pROJ_T5twJtVn2itzav4x5fypyJWsBr5YbjWUTMFokg@mail.gmail.com>
Message-ID: <20171116235019.GA55530@samitolvanen.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 16, 2017 at 11:20:40PM +0000, Ard Biesheuvel wrote:
> So at which point is the IR in a partially linked object file
> converted into executable code?

At the final module link step (cmd_ld_ko_o) in scripts/Makefile.modpost,
added in patch 12.

Sami
