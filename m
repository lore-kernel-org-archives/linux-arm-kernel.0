From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 16 Jul 2015 09:52:58 +0200
Subject: [PATCH 1/2] gpio: dwapb: Use human understandable gpio numbering.
In-Reply-To: <267A46E7-C5C5-4696-90CC-D44F4130B3EF@smart-africa.com>
References: <cover.1435777856.git.rcochran@linutronix.de>
 <d6b5ce85a17164970d454583560e07f7aed7b8ca.1435777856.git.rcochran@linutronix.de>
 <267A46E7-C5C5-4696-90CC-D44F4130B3EF@smart-africa.com>
Message-ID: <CACRpkdavWungUrU02dxObW1BUK5uELFHgDQMXmQwqdzzem2zuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 2, 2015 at 9:05 AM, Michael van der Westhuizen
<michael@smart-africa.com> wrote:

> In my case, I have quite a lot of vendor-supplied code that needs the numbers to
> be stable and backward compatible.  This quickly devolves into a discussion of
> GPIOs in sysfs as an ABI, which is not a discussion I want to have :)

That is impossible to avoid.

What you're saying is you just want to drill a hole in the boat and not
have a discussion whether the boat is going to float after this or
not.

Yours,
Linus Walleij
