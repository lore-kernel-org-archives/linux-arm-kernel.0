From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 3 Feb 2017 08:30:09 -0800
Subject: [PATCH v5 0/3] modversions: redefine kcrctab entries as 32-bit
 values
In-Reply-To: <1486115647-27680-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1486115647-27680-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CA+55aFz8faoGYBqkHuGPy4yp+SU5brCbkOCdZNTgfdDzkN8hOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 3, 2017 at 1:54 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> This v4 is a followup to [0] 'modversions: redefine kcrctab entries as
> relative CRC pointers' [...]

ok, I have this in a local branch now, assuming it passes my
(admittedly fairly superficial) testing I'll merge it so that we can
put this whole sorry saga behind us.

Thanks,

             Linus
