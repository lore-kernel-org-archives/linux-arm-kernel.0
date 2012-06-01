From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 1 Jun 2012 09:53:15 +0800
Subject: [PATCH RFC 2/3] i2c-nomadik: turn the platform driver to an amba
 driver
In-Reply-To: <20120531180204.GA28779@mail.gnudd.com>
References: <cover.1338398567.git.rubini@gnudd.com>
 <349645b61d0b28f6e84f7ae1f2c8c28e12a11d92.1338398567.git.rubini@gnudd.com>
 <CACRpkdZ79=B8N7omxYY4UPotg8gYotfLeBRViYMr8hA-Uhie0w@mail.gmail.com>
 <4FC72DDF.7080209@codethink.co.uk>
 <CACRpkdZpjn0RBGY+CqqSW3ip0MSQUJSaqN0GD=a4THnPHNM-jg@mail.gmail.com>
 <20120531180204.GA28779@mail.gnudd.com>
Message-ID: <CACRpkdZXnuQe5NXyQBEZJD71Rs=+wvmXkw-4oT53FdU7KE7m2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 1, 2012 at 2:02 AM, Alessandro Rubini <rubini@gnudd.com> wrote:

> So I'll resubmit in the right way (-M, include/linux/platform_data)
> as soon as I have information for ftd fixup.

OK if nothing happens you can probably just go in and patch:
arch/arm/boot/dts/db8500.dtsi

I suspect it's just the compatible= that needs to be changed to
"arm,primecell" or just have that string added to the others that
are already there for each i2c device entry.

Yours,
Linus Walleij
