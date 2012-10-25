From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Oct 2012 17:58:42 +0200
Subject: [GIT PULL] first set of ux500 for ARM SoC for v3.8
In-Reply-To: <201210251513.43931.arnd@arndb.de>
References: <CACRpkdasaP_xVfQtzq29UNJBXetrUUzqpn90T6_Gr0kOsV8GeQ@mail.gmail.com>
 <201210251344.44546.arnd@arndb.de>
 <CACRpkdZ9fUUugHAPGw8kEZDFnDWyyZ-b2iUdfCu2Hhhg4swaPQ@mail.gmail.com>
 <201210251513.43931.arnd@arndb.de>
Message-ID: <CACRpkdbE6asK01qY9Zm_WKzFRp3u1aKg-kzev_HUGUmsvpn7Lw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2012 at 5:13 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The tag looks great, but you were sending the pull request for
> the branch "ux500-core", not for the tag "ux500-core-for-arm-soc".
>
> This has happened to me a few times before, especially when pushing
> the tag just before sending the pull request. In that case,
> git-request-pull cannot find the tag on the server because it has
> not been mirrored back from the git+ssh server to the publically
> accessible one that it reads the tags from.

Ah yes this mirror thing is a bit dangerous, I usually check it
by inspecting the warning message that request-pull generates,
but must've missed it.

Yours,
Linus Walleij
