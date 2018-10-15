From: keescook@chromium.org (Kees Cook)
Date: Mon, 15 Oct 2018 15:42:31 -0700
Subject: [PATCH 00/17] ARMv8.3 pointer authentication support
In-Reply-To: <20181005084754.20950-1-kristina.martsenko@arm.com>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
Message-ID: <CAGXu5jLtxRitee143FE37PYkPCs0UArGgNEsiU8fzsQL9N8S-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 5, 2018 at 1:47 AM, Kristina Martsenko
<kristina.martsenko@arm.com> wrote:
> This series adds support for the ARMv8.3 pointer authentication
> extension. The series contains Mark's original patches to enable pointer
> authentication for userspace [1], followed by early RFC patches using
> pointer authentication in the kernel.

It wasn't obvious to me where the PAC mismatch exceptions will be
caught. I'm mainly curious to compare the PAC exception handling to
the existing stack-protector panic(). Can you point me to which
routines manage that? (Perhaps I just missed it in the series...)

Thanks for the series! I'm quite excited for ARMv8.3 hardware. :)

-Kees

-- 
Kees Cook
Pixel Security
