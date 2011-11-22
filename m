From: rubini@unipv.it (Alessandro Rubini)
Date: Tue, 22 Nov 2011 12:56:32 +0100
Subject: [GIT PULL] ARM: amba: Enable module alias autogeneration for
 AMBA drivers
In-Reply-To: <1321961573-4562-1-git-send-email-dave.martin@linaro.org>
References: <1321961573-4562-1-git-send-email-dave.martin@linaro.org> 
Message-ID: <20111122115632.GA5165@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I have Acks on some of the driver patches and no comments on the
> rest.  I've been circulating these for some time, so if you're
> happy to pull those driver patches via your tree, please go ahead.

Sure I have no problem with the nomadik-rng.c, (so please have my
Acked-by: -- sorry for not noting it earlier) but I think this
file2alias thing needs a serious rework to split each bus in a
different file, using ELF sections like we do elsewhere.

I posted a patch last week but I got no comment at all. Maybe this
is the time to ask for comments? I can rebase and repost if needed.

  lkml.org/lkml/2011/11/4/125 (0/2: description of the work)
  lkml.org/lkml/2011/11/4/126 (1/2: turn the if plethora to table lookup)
  lkml.org/lkml/2011/11/4/127 (2/2: partial split to type-specific files).

thanks
/alessandro
