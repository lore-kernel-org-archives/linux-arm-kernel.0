From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 3 May 2012 19:14:59 +0200
Subject: [PATCH 7.2/15] ARM: ux500: Disable SMSC911x platform code
 registration when DT is enabled
In-Reply-To: <201205031257.52100.arnd@arndb.de>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
 <CACRpkdZzAQNJ9ejKJJQJhEPjO9VO+fPHmPeCErg8XOj-dLc3gA@mail.gmail.com>
 <4F967986.6090808@linaro.org> <201205031257.52100.arnd@arndb.de>
Message-ID: <CACRpkdaLG+LwNpKX_52+scLrNbezvRXEuCfF5CAb4XFOSD4xag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 3, 2012 at 2:57 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> This version of the patch looks good, the version that was applied does not.
> (...)
> Linus and Lee, what's going on here?

Probably just my screwups when applying Lee's patches out-of-order
and splitting them.

I saw lee sent a new pull request with his baseline, throw the devcietree
branch from me out and use his branch instead.

Sorry for the mess!
Linus Walleij
