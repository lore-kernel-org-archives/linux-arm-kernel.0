From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 12 Mar 2014 14:38:14 +0100
Subject: [PATCH 2/4] ARM: ux500: storage class should be before const
 qualifier
In-Reply-To: <1394037253-1702-1-git-send-email-tklauser@distanz.ch>
References: <1394037253-1702-1-git-send-email-tklauser@distanz.ch>
Message-ID: <CACRpkdYowgXf8x=hd7Cx8Ax9nTpqeF+NCgX5dcPL4qszGaU+-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 5, 2014 at 5:34 PM, Tobias Klauser <tklauser@distanz.ch> wrote:

> The C99 specification states in section 6.11.5:
>
> The placement of a storage-class specifier other than at the beginning
> of the declaration specifiers in a declaration is an obsolescent
> feature.
>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Patch applied for fixes.

Yours,
Linus Walleij
