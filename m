From: bp@alien8.de (Borislav Petkov)
Date: Wed, 6 May 2015 19:12:42 +0200
Subject: [PATCH v8 0/4] edac: Add APM X-Gene SoC memory controller EDAC
 driver
In-Reply-To: <CAPw-ZT=LepJr2Smjy81yhcTANdMRw99x1vR9rMoYsnHW_P3HPg@mail.gmail.com>
References: <1430884947-16787-1-git-send-email-lho@apm.com>
 <20150506084143.GA22949@pd.tnic>
 <CAPw-ZT=LepJr2Smjy81yhcTANdMRw99x1vR9rMoYsnHW_P3HPg@mail.gmail.com>
Message-ID: <20150506171242.GG22949@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 06, 2015 at 10:00:45AM -0700, Loc Ho wrote:
> It was discussed with Rob already in previous email. As we don't touch
> the shared status registers besides reading status, it will just
> register as shared interrupt.

I don't see why that justifies the addition of an
edac_xgene-<functional_unit> compilation unit and thus an .ko module per
shared interrupt handler.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
