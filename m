From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 13 Jun 2013 22:23:05 +0200
Subject: [PATCH 12/39] ARM: u300: set up board power from device tree
In-Reply-To: <20130601190203.GK16790@sirena.org.uk>
References: <CACRpkdb=Z8oFpvxni6jyaWHoQOjhFkWQ_71ku=h5UFk9pzJZ2A@mail.gmail.com>
 <20130601190203.GK16790@sirena.org.uk>
Message-ID: <CACRpkdbNQS-Rf1PSDKza1RRJyer2PoZidrpW5sQwG23=H0m5eQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 1, 2013 at 9:02 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, May 31, 2013 at 04:02:34PM +0200, Linus Walleij wrote:
>
>> Mark: would you be OK with the ab3100 driver hogging one of its
>> own regulators?
>
> I'm not sure what that means, sorry.  Could someone send a patch please?

I've sent a patch so you can see what I mean by this.
(Subject [PATCH 2/2] regulators: ab3100: bootstrap board power)

It is changing the stuff proposed so far over to this way of
doing things.

If this approach is fine I'd prefer if we keep this on top of
the stack instead of me going back to amend everything
since it creates a messy rebase-hell for me. The end result
is textually identical.

Yours,
Linus Walleij
