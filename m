From: tj@kernel.org (Tejun Heo)
Date: Wed, 18 Jan 2017 11:23:08 -0800
Subject: [PATCH v2] ata: xgene: Enable NCQ support for APM X-Gene SATA
 controller hardware v1.1
In-Reply-To: <CAFd313wajZzZWGQy20obf4k_7RO43Q10NiBa-8TVYxo3J93inA@mail.gmail.com>
References: <1479462345-13942-1-git-send-email-rsahu@apm.com>
 <CAFd313wajZzZWGQy20obf4k_7RO43Q10NiBa-8TVYxo3J93inA@mail.gmail.com>
Message-ID: <20170118192308.GC9171@mtj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Jan 17, 2017 at 08:25:21PM +0530, Rameshwar Sahu wrote:
> Hi Tejun,
> 
> On Fri, Nov 18, 2016 at 3:15 PM, Rameshwar Prasad Sahu <rsahu@apm.com> wrote:
> > This patch enables NCQ support for APM X-Gene SATA controller hardware v1.1
> > that was broken with hardware v1.0. Second thing, here we should not assume
> > XGENE_AHCI_V2 always in case of having valid _CID in ACPI table. I need to
> > remove this assumption because V1_1 also has a valid _CID for backward
> > compatibly with v1.
> >
> > v2 changes:
> >         1. Changed patch description
> >
> > Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>

Hmm... I don't have the patch in my queue.  Can you please resend it?

Thanks.

-- 
tejun
