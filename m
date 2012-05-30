From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 30 May 2012 15:43:49 +0800
Subject: [PATCH 18/22] mfd: Remove redundant Kconfig entry
In-Reply-To: <4FC5CE2E.6000501@linaro.org>
References: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
 <1338353260-10097-19-git-send-email-lee.jones@linaro.org>
 <CACRpkdYpCMRurpDgz5X-Qsv5qUgzeVX3S8trWHByTaw6R35_jg@mail.gmail.com>
 <4FC5CE2E.6000501@linaro.org>
Message-ID: <CACRpkdZgf4TasFza0LW4nPaDkK-gqawKGDFhP2nJdTjG=+C58A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2012 at 3:37 PM, Lee Jones <lee.jones@linaro.org> wrote:

>> You need to move these dependencies under the AB8500_CORE config
>> entry instead.
>
> Already done and upstreamed: 21f082a66177852365df0c955ecaef50fba9a691

Yes the PRCMU driver will select this one, I was more thinking if it shoul
select both but this will work.
Acked-by.

Linus Walleij
