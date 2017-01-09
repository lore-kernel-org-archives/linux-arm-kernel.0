From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 9 Jan 2017 12:17:13 -0800
Subject: [PATCH 1/4] watchdog: coh901327_wdt: Simplify error handling in
 probe function
In-Reply-To: <CACRpkdbb9O=zRNox9RO9bNkAJ0grZ7vHy+8=9udJj0_Gw+k5hA@mail.gmail.com>
References: <1483500343-27113-1-git-send-email-linux@roeck-us.net>
 <CACRpkdbb9O=zRNox9RO9bNkAJ0grZ7vHy+8=9udJj0_Gw+k5hA@mail.gmail.com>
Message-ID: <20170109201713.GB8668@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2017 at 08:38:03PM +0100, Linus Walleij wrote:
> On Wed, Jan 4, 2017 at 4:25 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > Checking if there is no error followed by a goto if there is one is
> > confusing. Reverse the logic.
> >
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
Thanks!

Guenter
