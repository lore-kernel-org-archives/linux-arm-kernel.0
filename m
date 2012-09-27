From: richard.genoud@gmail.com (Richard Genoud)
Date: Thu, 27 Sep 2012 11:08:39 +0200
Subject: [PATCH RESEND] ARM: add dtbImage.<dt> and dtbuImage.<dt> rules
In-Reply-To: <20120927082955.GR17667@game.jcrosoft.org>
References: <504DFBBF.5010202@free-electrons.com>
 <1348733441-11626-1-git-send-email-richard.genoud@gmail.com>
 <20120927082955.GR17667@game.jcrosoft.org>
Message-ID: <CACQ1gAgwv4pBFZBrVZiWM2_=OneUO-s16LufSENx27gMC3DUig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/9/27 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>:
>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>> Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> as discuss with Grant no this is a temporary solution so no Makefile Target
>
> so nack

hum, it doesn't seems to be temporary on powerpc.
cf 25431333813686654907ab987fb5de10c10a16db
and
ARCH=powerpc make help

So what's the problem on arm ?
