From: elezegarcia@gmail.com (Ezequiel Garcia)
Date: Sun, 23 Jun 2013 19:58:10 -0300
Subject: No stable driver/module api?
In-Reply-To: <CABp-a4eHep=hx7HQ=Og0GC0t=CyE8u2sVt7BwyVMJb9zjA2ePw@mail.gmail.com>
References: <CABp-a4eHep=hx7HQ=Og0GC0t=CyE8u2sVt7BwyVMJb9zjA2ePw@mail.gmail.com>
Message-ID: <CALF0-+VYHoDLapMv_xYbjc2DRFdLCt0bYUgaOfgmy8V1TvxRbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Per,

On Sun, Jun 23, 2013 at 2:29 PM, Per Strandh <per.strandh@gmail.com> wrote:
>
> I'm working for a company with arm-based embedded-linux products.
> Both the hardware and software is developed by ourselves.
>

Have you considered mainlining your drivers and the other changes made
to the kernel?

This way you won't need to bother with API changes, and only provide some help
maintaining the code from time to time. In my own experience, this is
less painful
than having to port your code on every release.
-- 
    Ezequiel
