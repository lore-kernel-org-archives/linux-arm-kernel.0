From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Nov 2018 22:51:51 +0100
Subject: [PATCH 0/9] Regenerate arm64 defconfig for current kernel
In-Reply-To: <6eb79d2e-1857-39b5-90f5-29bc13bce16a@free.fr>
References: <8b49a92b-ca92-1fca-cd09-3bcd7a3dcbb9@free.fr>
 <6eb79d2e-1857-39b5-90f5-29bc13bce16a@free.fr>
Message-ID: <CAK8P3a1QE1Vr8_3m1=dhgjWkn9HLYwpmNUVZ4+fVZdRwpX=ZEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 7, 2018 at 9:39 PM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>
> Arnd, Olof,
>
> The following patch series was sent to arm at kernel.org
> but the messages bounced because the SMTP server is
> currently blacklisted. Can you get the patches through
> the LAKML mailing list?

Yes, that worked fine, and they ended up in the right folder for
me because of the to:arm at kernel.org recipient.

All patches look good to me, thanks a lot for doing this!

One point about the changelogs: in some of them you just
list the commit that changed things, but don't explain what
the impact of that commit was (symbol dropped, always
selected, etc). I always like to see changelog texts in full
sentences, so if you can spend a few more minutes on this,
would you send a v2 with that changed?

       Arnd
