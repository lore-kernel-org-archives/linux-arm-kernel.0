From: peter@korsgaard.com (Peter Korsgaard)
Date: Tue, 30 Sep 2014 18:57:12 +0200
Subject: [PATCH 3/6] hwrng: atmel: add DT support
In-Reply-To: <1412093987-30241-4-git-send-email-boris.brezillon@free-electrons.com>
 (Boris Brezillon's message of "Tue, 30 Sep 2014 18:19:44 +0200")
References: <1412093987-30241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1412093987-30241-4-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <87fvf9oxlj.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Boris" == Boris Brezillon <boris.brezillon@free-electrons.com> writes:

 > Add DT support.
 > Make the driver depend on CONFIG_OF as at91sam9g45 was the only SoC making
 > use of the TRNG block and this SoC is now fully migrated to DT.

 > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Acked-by: Peter Korsgaard <peter@korsgaard.com>

-- 
Bye, Peter Korsgaard
