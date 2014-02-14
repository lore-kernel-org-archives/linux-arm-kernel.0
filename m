From: keescook@chromium.org (Kees Cook)
Date: Fri, 14 Feb 2014 11:31:21 -0800
Subject: [PATCH v3] ARM: mm: report both sections from PMD
In-Reply-To: <20140214192322.GJ30257@n2100.arm.linux.org.uk>
References: <20140213195230.GA15275@www.outflux.net>
 <20140214101724.GC10590@arm.com>
 <CAGXu5jKYq=0Ud-A6bdD2zMe=+r0S7nja8Rg+OxeT+JHzdpwTKg@mail.gmail.com>
 <20140214192322.GJ30257@n2100.arm.linux.org.uk>
Message-ID: <CAGXu5jK6Ro+u1VBsnQvNMZz4+iUZPLSRsd98oBgXCQAx=vW2YA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 14, 2014 at 11:23 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>> https://lkml.org/lkml/2014/2/12/662
>
> It's not that simple, because APX in section descriptors doesn't exist
> on pre-v6 ARMs.  This needs to be conditional upon the CPU arch.

Ah! Okay, do we need a single #define to describe the expected masks
and values? What should it look like for pre-v6 ARMs?

-Kees

-- 
Kees Cook
Chrome OS Security
