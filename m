From: per.forlin@linaro.org (Per Forlin)
Date: Tue, 26 Apr 2011 12:33:29 +0200
Subject: since when does ARM map the kernel memory in sections?
In-Reply-To: <BANLkTimZZEr8fqXbuBjpYxF1quBFv7Oihg@mail.gmail.com>
References: <201104122052.17453.pwaechtler@mac.com>
	<BANLkTin0NMo7ZDrnTmBghYeRC9wxJu7zrw@mail.gmail.com>
	<20110412203303.GA16019@shareable.org>
	<20110418135243.GB1479@ucw.cz>
	<20110418170752.GQ16019@shareable.org>
	<20110422154344.GA7526@ucw.cz>
	<BANLkTimZZEr8fqXbuBjpYxF1quBFv7Oihg@mail.gmail.com>
Message-ID: <BANLkTikNqO_xGgsUrZ2fid4ZmA8P6AoHLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 April 2011 11:23, Linus Walleij <linus.walleij@linaro.org> wrote:
> 2011/4/22 Pavel Machek <pavel@ucw.cz>:
>
>> Plus, I was told new MMC standard has "write reliable" option...
>
> I think Per F?rlin looked into reliable write. The latest eMMC cards
> has this, but OTOMH it was too darn slow to be used on current
> chips/"cards".
>
> Per, Sebastian: any details?
I had plans to add reliable writes and do benchmarking but I never got
to it. Right now I have no plans to pick it up.

>
> Yours,
> Linus Walleij
>
Regards,
Per
