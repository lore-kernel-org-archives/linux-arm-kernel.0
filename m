From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 24 Sep 2013 14:34:30 +0200
Subject: [PATCH RESEND] ARM: add dtbImage.<dt> and dtbuImage.<dt> rules
In-Reply-To: <20130924121939.GD12758@n2100.arm.linux.org.uk>
References: <504DFBBF.5010202@free-electrons.com>
 <1348733441-11626-1-git-send-email-richard.genoud@gmail.com>
 <20120927082955.GR17667@game.jcrosoft.org>
 <CACQ1gAgwv4pBFZBrVZiWM2_=OneUO-s16LufSENx27gMC3DUig@mail.gmail.com>
 <52416F97.802@keymile.com> <20130924120152.GI11119@titan.lakedaemon.net>
 <20130924121939.GD12758@n2100.arm.linux.org.uk>
Message-ID: <CACQ1gAjNNszH3fOf-=RcuCQRrqu53i8ss40OrHQxd-Uah_ESZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/9/24 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> Modern platforms
> should be using a DT compatible boot loader, which means you don't
> want to use the DTB appended to zImage method.

Even small bootloaders like at91bootstrap can handle DT blob now (that
was my main problem at the time I wrote this patch)
So I don't use it anymore. (but as a developer tool, this can be convenient).

Richard.
