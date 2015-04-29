From: bp@alien8.de (Borislav Petkov)
Date: Wed, 29 Apr 2015 23:49:24 +0200
Subject: [PATCH v7 3/5] Documentation: Add documentation for the APM
 X-Gene SoC EDAC DTS binding
In-Reply-To: <CAPw-ZTnLR10Zr_p8L3-1nBZ+jKE1HCwERDmO=S5as2GLqime3A@mail.gmail.com>
References: <1430259045-19012-1-git-send-email-lho@apm.com>
 <1430259045-19012-2-git-send-email-lho@apm.com>
 <1430259045-19012-3-git-send-email-lho@apm.com>
 <1430259045-19012-4-git-send-email-lho@apm.com>
 <CAL_Jsq+nhPUxHxrStB9cdy1YzE7tVPFVR1MrWq3Bz-JUa=3Rvg@mail.gmail.com>
 <CAPw-ZTnLR10Zr_p8L3-1nBZ+jKE1HCwERDmO=S5as2GLqime3A@mail.gmail.com>
Message-ID: <20150429214924.GH5498@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 29, 2015 at 02:33:28PM -0700, Loc Ho wrote:
> > Similar comments for the rest. I would define memory controller
> > bindings and EDAC driver, then worry about the rest.
> 
> Okay.. As comment in following emails, I will break up the driver into
> multiple drivers and focus only on the memory controller driver first.

Please no multiple EDAC drivers. Or do you mean something else here?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
