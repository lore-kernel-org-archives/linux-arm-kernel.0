From: keescook@chromium.org (Kees Cook)
Date: Fri, 29 Jun 2018 12:47:03 -0700
Subject: [PATCH] arm64: Clear the stack
In-Reply-To: <20180629190553.7282-1-labbott@redhat.com>
References: <20180629190553.7282-1-labbott@redhat.com>
Message-ID: <CAGXu5jK+nqbRnk=RQW0wPrcEjqvmuR3dWKxyaXqXHn9__Kx0EA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2018 at 12:05 PM, Laura Abbott <labbott@redhat.com> wrote:
> Implementation of stackleak based heavily on the x86 version

Awesome!

Now I just have to figure out how to unbreak cross-compilation after
the kconfig changes to gcc-plugins. Whoops. :)

-Kees

-- 
Kees Cook
Pixel Security
