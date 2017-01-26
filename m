From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 26 Jan 2017 10:13:10 +0100
Subject: [GIT PULL] soc: samsung: Drivers for v4.11
In-Reply-To: <20170120181343.12570-1-krzk@kernel.org>
References: <20170120181343.12570-1-krzk@kernel.org>
Message-ID: <CACRpkdZebsd5MfARWL2WbKkAuXfjEe6p_k5tYwPFF6kSsCXDdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 7:13 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Few changes in Exynos PMU driver including one that is needed by pinctrl
> driver for runtime PM. We want to move forward with the RPM for our drivers
> while keeping still DT ABI.
>
> This tag is also for Linus Walleij to pull - base for pinctrl changes.

Do I need it? I.e. will my branch not compile without this, or is this
just a runtime problem?

Yours,
Linus Walleij
