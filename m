From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 22 Oct 2012 10:54:34 +0200
Subject: [PATCH RFC 02/15 v5] gpio: Add sysfs support to block GPIO API
In-Reply-To: <20121019180232.GD3375@kroah.com>
References: <1350477107-26512-1-git-send-email-stigge@antcom.de>
 <1350477107-26512-3-git-send-email-stigge@antcom.de>
 <20121017190520.GC25996@kroah.com> <507FD4EB.1080204@antcom.de>
 <20121019180232.GD3375@kroah.com>
Message-ID: <CACRpkdYNwj=nr8Q8D73rtN-4_ciUM8nJuUMExTuMtcJAFGB=CA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2012 at 8:02 PM, Greg KH <gregkh@linuxfoundation.org> wrote:

> We used to have problems with attributes removing/adding devices or
> attributes from their callbacks, but that has been fixed up now, and the
> fact that the other gpio code works this way is good enough precedence
> to keep me from objecting to it.

OK thanks I get this now too...

Yours,
Linus Walleij
