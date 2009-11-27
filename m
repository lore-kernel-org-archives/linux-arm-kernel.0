From: daniel@caiaq.de (Daniel Mack)
Date: Fri, 27 Nov 2009 11:15:09 +0100
Subject: frame buffer i.MX31 ADS SHARP LCD
In-Reply-To: <DC6F86A94046A64094043D44A3A708F70C1137E4@sestoex02.enea.se>
References: <DC6F86A94046A64094043D44A3A708F70C1137E4@sestoex02.enea.se>
Message-ID: <20091127101509.GO14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2009 at 10:55:22AM +0100, Piotr Rozycki wrote:
> I wonder if there is a good driver code examples for i.MX31 ADS platform
> to read something from the frame buffer with SHARP LCD. 
> 
> Ideally, a code with only one c-file and h file.

Sure - look at Sascha's mxc-master tree and find an example in
arch/arm/mach-mx3/mx31lilly-db.c. You might need to tweak the display
timings for your LCD of course, but that should be easy.

Daniel
