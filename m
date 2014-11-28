From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 28 Nov 2014 16:48:39 +0000
Subject: [PATCH v2 RESEND 1/2] ARM: vexpress: Remove non-DT code
In-Reply-To: <1417189984.4371.12.camel@arm.com>
References: <1416939455-1814-1-git-send-email-pawel.moll@arm.com>
 <201411281608.34978.arnd@arndb.de>
 <20141128153026.GU3836@n2100.arm.linux.org.uk>
 <1417189984.4371.12.camel@arm.com>
Message-ID: <20141128164839.GV3836@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 28, 2014 at 03:53:04PM +0000, Pawel Moll wrote:
> To summarize, I believe that setting CONFIG_REGULATOR=y (as in
> vexpress_defconfig) should solve your issue.

It does, thanks.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
