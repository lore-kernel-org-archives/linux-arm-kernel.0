From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Jul 2014 10:08:12 +0200
Subject: [PATCH] ARM: ux500: storage class should be before const qualifier
In-Reply-To: <1404204468-8715-1-git-send-email-tklauser@distanz.ch>
References: <1404204468-8715-1-git-send-email-tklauser@distanz.ch>
Message-ID: <CACRpkdYBUSzggYfqnNSoGpxpzuPg6bhRYZECF9VE2hTu-29UOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 1, 2014 at 10:47 AM, Tobias Klauser <tklauser@distanz.ch> wrote:

> The C99 specification states in section 6.11.5:
>
> The placement of a storage-class specifier other than at the beginning
> of the declaration specifiers in a declaration is an obsolescent
> feature.
>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Applied to my stack of ux500 cleanups.

Yours,
Linus Walleij
