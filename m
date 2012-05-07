From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 May 2012 15:09:42 +0200
Subject: [PATCH] gpiolib: Add of_get_gpio_chip_by_phandle() helper
In-Reply-To: <CAOh2x=kvdB3VxGCToBBUkXAkTUh8bmpgu_rbkhxY4qLt3Lcp2w@mail.gmail.com>
References: <cdf5352edf6b32e2505e1c7ba9997613150094c1.1335949228.git.viresh.kumar@st.com>
 <4FA15267.4090306@wwwdotorg.org>
 <CAOh2x=nrNDrtNjOroWOm6HkYkc3f2qfaWrtN97d1M3rWv1qmsQ@mail.gmail.com>
 <4FA16934.3080208@wwwdotorg.org>
 <CAOh2x=kvdB3VxGCToBBUkXAkTUh8bmpgu_rbkhxY4qLt3Lcp2w@mail.gmail.com>
Message-ID: <CACRpkdaBo1MsaVDvJhOppHmT_rBKLiBe1aqOX5P8SRsH-60f7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 2, 2012 at 7:12 PM, viresh kumar <viresh.linux@gmail.com> wrote:

> There is one more way of doing this
> which is implemented for u300.
> There device node of gpio is added from pinctrl driver.
>
> I didn't liked that. Sorry Linus :(

Heh, I don't think it looks good either, but it works.

The most brutal way is to merge both driver into one file and only
spawn one device for them, with several memory resources associated.

Linus Walleij
