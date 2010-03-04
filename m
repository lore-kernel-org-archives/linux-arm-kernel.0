From: ben@simtec.co.uk (Ben Dooks)
Date: Thu, 04 Mar 2010 22:59:38 +0000
Subject: [PATCH 2.6.34] USB: Fix s3c-hsotg build following Samsung platform
	header moves
In-Reply-To: <1267469502-19560-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1267469502-19560-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <4B903B5A.3070204@simtec.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> Fix a reference to regs-sys.h got missed in the reorganisation of
> the Samsung platform headers targetted for 2.6.34.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

anyone mind if this gets merged into my next tree and given to RMK?

-- 
Ben Dooks, Design & Software Engineer, Simtec Electronics

http://www.simtec.co.uk/
