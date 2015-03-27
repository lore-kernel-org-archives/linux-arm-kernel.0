From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 27 Mar 2015 10:04:39 +0100
Subject: [PATCH 0/2] tc3589x OF only enforcement
In-Reply-To: <1426776765-18812-1-git-send-email-linus.walleij@linaro.org>
References: <1426776765-18812-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdZC-+fZXRAqnir2+pyq-es=-zA9jS2qGUiOF75KqzSLqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 19, 2015 at 3:52 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> These two patches removes the non-DT probe/config path from the
> TC3589x driver. I suggest merging both through the MFD tree if
> Dmitry can ACK the input patch.

Lee it seems Dmitry ACKed these patches, can you merge those
two patches into MFD? I don't think there will be any cross-tree deps
so you can just carry them  in MFD without any immutable branch business.

Yours,
Linus Walleij
