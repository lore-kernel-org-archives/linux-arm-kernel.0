From: keescook@google.com (Kees Cook)
Date: Wed, 15 Jun 2016 15:54:38 -0700
Subject: kexec failures with DEBUG_RODATA
In-Reply-To: <20160615224228.GK1041@n2100.armlinux.org.uk>
References: <20160614175920.GD1041@n2100.armlinux.org.uk>
 <CAGXu5j+5j32HO0rQtF2hcqMUBaa8cyxgLT4JvaZ6LL2WPj_zjw@mail.gmail.com>
 <20160615211359.GJ1041@n2100.armlinux.org.uk>
 <CAGXu5jKRBA9b6gos+FG7iV2ppxtAERstNPschxA0z=aDL_y1YA@mail.gmail.com>
 <20160615224228.GK1041@n2100.armlinux.org.uk>
Message-ID: <CAGXu5jLqNeYe_=7a5XC6UW4G3WiRQrrBvgernmugw_r2y0Nshg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 3:42 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> In fact, the apparent confusion over this reinforces my belief that we
> should _not_ give the size of the uncompressed image at all.
>
> The boot environment must be setup such that there is room for the
> uncompressed image (aligned currently to 256 bytes) followed by the
> size of the compressed image, with any appended DTBs included.
> Anything which is located below that is likely to get trampled by
> the decompressor.

Okay, sounds reasonable to me. :)

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
