From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 4 Jan 2018 17:10:56 +0100
Subject: [GIT PULL] ARM: uniphier: fixes for v4.15 (2nd)
In-Reply-To: <CAK7LNAQodyYzeD9kujN05EQQzfZPwWOq1AmBCvKd2FDnnRF7AQ@mail.gmail.com>
References: <CAK7LNAQodyYzeD9kujN05EQQzfZPwWOq1AmBCvKd2FDnnRF7AQ@mail.gmail.com>
Message-ID: <CAK8P3a1QVn0PXde3q3xVMtdm2r3gS5yqdvSh15V1V+BFtTt9aA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 29, 2017 at 1:30 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Hi Arnd, Olof,
>
> This is the 2nd bug-fix pull request for v4.15.
> Just one DT fix.  Please pull!

I've ended up cherry-picking that commit manually into the fixes branch:
We haven't updated the fixes branch to a later -rc, and your pull request
was based on -rc3, so pulling it would create an ugly backmerge.

You did nothing wrong here, so it seemed unnecessary to ask you for
a respin based on -rc1. Hope that works for you.

     Arnd
