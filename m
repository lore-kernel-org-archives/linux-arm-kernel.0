From: rubini@unipv.it (Alessandro Rubini)
Date: Wed, 11 Jan 2012 10:41:37 +0100
Subject: [PATCH 1/3] plat-nomadik: get rid of global mtu base pointer
In-Reply-To: <1326272680-5635-1-git-send-email-linus.walleij@stericsson.com>
References: <1326272680-5635-1-git-send-email-linus.walleij@stericsson.com> 
Message-ID: <20120111094137.GA28745@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Pass the base offset to the Nomadik MTU timer in the init call
> instead of keeping a global pointer to be assigned.
>
> Cc: Alessandro Rubini <rubini@unipv.it>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Alessandro Rubini <rubini@unipv.it>

(looks good but I didn't manage to test it myself, I know you booted it
on the same board I have, so I don't foresse any issues)

/alessandro
