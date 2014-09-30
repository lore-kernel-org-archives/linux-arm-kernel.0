From: peter@korsgaard.com (Peter Korsgaard)
Date: Tue, 30 Sep 2014 19:35:37 +0200
Subject: [PATCH 4/6] hwrng: atmel: Add TRNG DT binding doc
In-Reply-To: <20140930192149.464ac50f@bbrezillon> (Boris Brezillon's message
 of "Tue, 30 Sep 2014 19:21:49 +0200")
References: <1412093987-30241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1412093987-30241-5-git-send-email-boris.brezillon@free-electrons.com>
 <87bnpxoww9.fsf@dell.be.48ers.dk> <20140930192149.464ac50f@bbrezillon>
Message-ID: <877g0lovti.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Boris" == Boris Brezillon <boris.brezillon@free-electrons.com> writes:

Hi,

 >> The interrupt isn't strictly speaking required as it isn't used by the
 >> driver, but as 9G45 has the signal wired up I guess it makes sense.

 > This irq might be used in a near future (in order to wait for data as
 > requested by hwrng code when the wait argument is true).
 > Thus I prefer to keep it as required.

Ok, fine by me.

-- 
Bye, Peter Korsgaard
