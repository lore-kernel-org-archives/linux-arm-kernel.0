From: sebastian@breakpoint.cc (Sebastian Andrzej Siewior)
Date: Mon, 26 Apr 2010 20:11:42 +0200
Subject: [PATCH] net/ipsec: don't treat EINPROGRESS as a regular error
In-Reply-To: <20100426011711.GA19734@gondor.apana.org.au>
References: <20091130211531.GK18101@deprecation.cyrius.com>
	<4B144627.7060901@gmail.com>
	<20091204212847.GC28480@deprecation.cyrius.com>
	<4BCB4009.70707@gmail.com>
	<20100418191719.GA2508@Chamillionaire.breakpoint.cc>
	<4BCE125F.30200@gmail.com>
	<20100424144215.GA9057@Chamillionaire.breakpoint.cc>
	<20100425011821.GA5284@gondor.apana.org.au>
	<20100425152928.GA14489@Chamillionaire.breakpoint.cc>
	<20100426011711.GA19734@gondor.apana.org.au>
Message-ID: <20100426181142.GA22245@Chamillionaire.breakpoint.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Herbert Xu | 2010-04-26 09:17:11 [+0800]:

>OK that was my fault.  Steffen had all the requisite EINPROGRESS
>checks in place but I told him to get rid of them.
>
>This patch should fix it.
Excellent job Herbert, it does solve the problem.

Sebastian
