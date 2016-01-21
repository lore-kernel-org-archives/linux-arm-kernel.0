From: pavel@denx.de (Pavel Machek)
Date: Thu, 21 Jan 2016 10:52:36 +0100
Subject: ARM: socfpga: SPI NOR support for Linux 4.4?
In-Reply-To: <20160120131654.GA18466@amd>
References: <1445979581-8080-1-git-send-email-dinguyen@opensource.altera.com>
 <20160120131654.GA18466@amd>
Message-ID: <20160121095236.GA4231@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Does anyone have QSPI NOR working in Linux 4.4?
> 
> There's branch with 4.3 support for socfpga on github, and I was able
> to extract working QSPI NOR from that, but there does not seem to be
> 4.4 branch, and master does not seem to contain that code.

Thanks go to Marek, who sent me series of working patches over private
email.

If someone is interested, I pushed most of the series to 
git at gitlab.denx.de:pavel/linux.git nor-v4.4:nor-4.4 .

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
