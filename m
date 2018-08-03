From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 Aug 2018 18:47:27 +0200
Subject: [RFC PATCH 6/8] gpio: omap: Add get/set_multiple() callbacks
In-Reply-To: <20180718235710.18242-7-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
 <20180718235710.18242-7-jmkrzyszt@gmail.com>
Message-ID: <CACRpkda8AC9Z635SWmit_RiaYbHA2TrwG-DsSg43vJ8E9Dq4GA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2018 at 1:56 AM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> This should make applications utilizing whole banks work faster.
>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Patch applied with Grygorii's ACK.
No reason to delay it, if there are any problems we will just revert it.

Yours,
Linus Walleij
