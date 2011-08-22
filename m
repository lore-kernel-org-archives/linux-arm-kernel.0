From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 22 Aug 2011 09:53:48 +0200
Subject: [PATCH 00/19] GPIO exodus and cleanup
In-Reply-To: <CACxGe6tEOnUzFjKMqNfp10b8SyuJDDFzg0eiPzhKNNCY55LECw@mail.gmail.com>
References: <1312978564-18069-1-git-send-email-linus.walleij@stericsson.com>
	<20110817090123.GD1006@n2100.arm.linux.org.uk>
	<CACRpkdbJOrb5rhgG0Chamt-ApLQnV69MQ=bqBwKqO3KJPaFd0A@mail.gmail.com>
	<CACRpkdYw96QD0sGOhA=osKYbnD6=MTqiAF=m5++BjM-s1Mn--w@mail.gmail.com>
	<CACxGe6tEOnUzFjKMqNfp10b8SyuJDDFzg0eiPzhKNNCY55LECw@mail.gmail.com>
Message-ID: <CACRpkdbPFuFHBuHzO2bP+z=za2kOFk4AZdgMVy=U6kcMmw9LSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 21, 2011 at 9:09 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Fri, Aug 19, 2011 at 5:45 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> Ping on this, on monday I'll pretend it's no big deal and pour them
>> into Russells patch tracker anyway, since he's managing more than
>> half of the kernels GPIO code in arch/arm/* anyway.
>
> If Russell is okay with it, then go ahead and merge it. ?I'm being
> pretty liberal about GPIO driver moves. ?I'm fine with them getting
> cleaned up after the drivers/gpio move.

Okay! Russell I've put them into your patch tracker as patches
7032/1 thru 7050/1 so you can pick and choose. I've rebased on
top of what's in -next hoping that the stuff there affecting these
file will mainly be identical to what's on your "gpio" branch.

Tell me if I should rebase on something specific or if there are
any problems.

Once this lands in -next I will take another round over arch/arm/*
and see if I can find more movement/split/cleanup items like these.

Thanks,
Linus Walleij
