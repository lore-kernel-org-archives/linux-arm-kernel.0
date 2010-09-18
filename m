From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Sat, 18 Sep 2010 21:01:54 +0200
Subject: [PATCH] at91: fix arch_gettimeoffset fallout
In-Reply-To: <20100918010839.GC21110@game.jcrosoft.org> (Jean-Christophe
	PLAGNIOL-VILLARD's message of "Sat, 18 Sep 2010 03:08:39 +0200")
References: <1284730276-21657-1-git-send-email-jacmet@sunsite.dk>
	<20100918010839.GC21110@game.jcrosoft.org>
Message-ID: <877hii6fkt.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Jean-Christophe" == Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> writes:

Hi,

 >> 5cfc8ee0bb51 (ARM: convert arm to arch_gettimeoffset()) marked all of
 >> at91 AND at91x40 as needing ARCH_USES_GETTIMEOFFSET, and hence no high
 >> res timer support / accurate clock_gettime() - But only at91x40 needs it.
 >> 
 >> Signed-off-by: Peter Korsgaard <peter.korsgaard@barco.com>

 Jean-Christophe> Acked-by: Jean-Christophe PLAGNIOL-VILLARD
 <plagnioj@jcrosoft.com>

Thanks, submitted to rmk's patch tracker as 6400 with those two
acked-by's and a a cc to stable@


-- 
Bye, Peter Korsgaard
