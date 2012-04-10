From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 Apr 2012 09:54:20 +0200
Subject: [PATCH] pinctrl: Add SPEAr pinctrl drivers
In-Reply-To: <4F7B7D1B.7030507@wwwdotorg.org>
References: <a1b7f612544a09989cec80a0318f35b6e48eb1d3.1333453148.git.viresh.kumar@st.com>
 <201204031347.35256.arnd@arndb.de>
 <CACRpkdZYccTvHEMa=4=-uoLZYQxEPS+932UPA7MGc+-94eLc6w@mail.gmail.com>
 <4F7B7D1B.7030507@wwwdotorg.org>
Message-ID: <CACRpkdZ5e-eqkPA8DP+L8_DnfQxQ-0+QRp8RcXSwOPU-ZNFSSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 4, 2012 at 12:43 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 04/03/2012 03:24 PM, Linus Walleij wrote:
>> So basically the pinctrl subsystem needs to return -EPROBE_DEFER
>> to the driver in this case, so it can escalate that further.
>
> Yes, I believe so.
>
> There should be a couple of comments in pinctrl now (well, perhaps some
> of them aren't there yet until my DT patches are applied!) that indicate
> where -EPROBE_DEFER should be returned.

OK I'll fix something...

Yours,
Linus Walleij
