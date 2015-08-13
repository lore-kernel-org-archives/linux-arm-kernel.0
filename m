From: bp@alien8.de (Borislav Petkov)
Date: Thu, 13 Aug 2015 05:36:40 +0200
Subject: [PATCH v3 3/4] edac: Add L3/SoC EDAC support to the APM X-Gene
 SoC EDAC driver
In-Reply-To: <CAPw-ZTkRytHUsUsDmTkfzzTYbcZnmTVRMkzNzg_9ZpdQH76rZw@mail.gmail.com>
References: <1439326077-25507-1-git-send-email-lho@apm.com>
 <1439326077-25507-2-git-send-email-lho@apm.com>
 <1439326077-25507-3-git-send-email-lho@apm.com>
 <1439326077-25507-4-git-send-email-lho@apm.com>
 <20150812105121.GE14011@nazgul.tnic>
 <CAPw-ZTkRytHUsUsDmTkfzzTYbcZnmTVRMkzNzg_9ZpdQH76rZw@mail.gmail.com>
Message-ID: <20150813033640.GB14432@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 10:50:52AM -0700, Loc Ho wrote:
> I intentional left this code as is so that the driver will still works
> with older version of the EDAC code.

Huh, what? I don't think this is how upstream development works.

> I had already reversed the logic for the L3 and SoC. Are you asking
> for the MC/PMD (earlier posting)? The MC/PMD routine isn't that big.
> Functions in general fit in an screen of 80 column?

Only for the ones where it becomes clumsy and flipping it would make the
code more readable. I'm not a hard 80 cols follower anyway.

> So, is there something that I am missing?

I hope you're not. But seeing the custom debugfs stuff left in the new
submission without any comment as to *why* you've left it, made me think
you didn't incorporate all feedback.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
