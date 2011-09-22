From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 22 Sep 2011 13:23:51 +0200
Subject: [GIT PULL] ux500-core for 3.2
In-Reply-To: <201109202248.01993.arnd@arndb.de>
References: <CACRpkdZofKjOrPFWNR-2D0LWx3NGMiLwyhf7gAVdvBGvQHqJLQ@mail.gmail.com>
	<201109202248.01993.arnd@arndb.de>
Message-ID: <CACRpkdakwQMaqJ4TwXxPJYjayMjO5iN68RQSZODGfhGCEjXnZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 20, 2011 at 10:48 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 20 September 2011, Linus Walleij wrote:
>> to the ARM SoC tree (ux500 branch or however you prefer to handle it)?
>> They have all been reviewed on the ARM list recently and are mostly
>> minor fixes and Lee Jones nice cleanup patch.
>
> I would really like to see this split into logical branches, even
> if there are just a few patches for each of them.

No problem. So the preferred scheme is to have three topics
for a SoC: fixes, cleanup and "new stuff" or something like that?

> It's also not clear if the two bug fix patches should be applied
> to 3.1 and -stable as well as 3.2. My feeling is that they should.

Depends. For Srinidhi's
"mach-ux500: enable fix for ARM errata 754322"
yes, definately.

For:
"mach-ux500: unlock I&D l2x0 caches before init"
it's a performance regression, nothing like a crash or so.

(I guess you're referring to these two?)

> If you want bug fixes to be backported, please add a 'Cc: stable at kernel.org'
> line after your Signed-off-by. If not, add an explanation to the
> pull request why they are not relevant for backporting.
(...)
> Please submit the two bug fixes again, rebased to an -rc release.

I'll fix.

Since it's just two patches I guess you can just pick these
two in plaintext? But I can make a pull request if you prefer...

Thanks,
Linus Walleij
