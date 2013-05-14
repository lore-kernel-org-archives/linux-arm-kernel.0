From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 May 2013 14:56:31 +0200
Subject: [RFC 19/42] drivers/pinctrl/spear: don't check resource with
 devm_ioremap_resource
In-Reply-To: <1368173847-5661-20-git-send-email-wsa@the-dreams.de>
References: <1368173847-5661-1-git-send-email-wsa@the-dreams.de>
 <1368173847-5661-20-git-send-email-wsa@the-dreams.de>
Message-ID: <CACRpkdYoDqsyE-oX5pBYx6v3txn=OjTLPoQOKkqaSLA5FNjYXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 10, 2013 at 10:17 AM, Wolfram Sang <wsa@the-dreams.de> wrote:

> devm_ioremap_resource does sanity checks on the given resource. No need to
> duplicate this in the driver.
>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Patch applied with Viresh's ACK.

Thanks!
Linus Walleij
