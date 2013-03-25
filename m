From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Mar 2013 19:17:54 +0000
Subject: [PATCH 3/6] ARM: remove fa526 CPU support
In-Reply-To: <op.wuinchfi2s3iss@ecaz>
References: <1363299178-8241-1-git-send-email-arnd@arndb.de>
 <op.wt67qgso2s3iss@ecaz> <op.wuinchfi2s3iss@ecaz>
Message-ID: <201303251917.54956.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 March 2013, Imre Kaloz wrote:
> Just tested 3.9-rc4 with your "ARM: gemini: get platform to build
> again" patch and the ones we have in our tree and it works on my
> WBD111. Please apply that patch and with a little luck I can get
> the other board working for 3.11, with the additional defconfig
> and some more hw support as well

Ok, excellent. Thanks a lot for testing!

> -- or if you would like so, 
> I can get a defconfig done for 3.10, but I'm not sure it makes
> too much sense.

I'd prefer to have the defconfig for 3.10, mainly so I notice
when we introduce build errors. Ideally the defconfig should
enable any code that is only available for gemini. I frequently
build all defconfigs when I apply cross-platform patches, and
try to use a clean build as the minimum acceptance criteria.

	Arnd
