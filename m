From: chripell@gmail.com (christian pellegrin)
Date: Thu, 13 May 2010 11:37:30 +0200
Subject: approaching last call for updatyes
In-Reply-To: <20100513091540.GK26401@trinity.fluff.org>
References: <20100513091540.GK26401@trinity.fluff.org>
Message-ID: <AANLkTimHifdCStUZJ_Xgyf2n5mA47Jdj2zscWNB13LDq@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The fix for NAND clock stop on idle is missing. Without it I suggest
to mark the option CONFIG_MTD_NAND_S3C2410_CLKSTOP broken.


-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
