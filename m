From: chris@printf.net (Chris Ball)
Date: Mon, 17 Mar 2014 13:07:04 +0000
Subject: [GIT PULL v2] SOCFPGA updates for 3.15, version 2
In-Reply-To: <201403171038.16362.arnd@arndb.de> (Arnd Bergmann's message of
 "Mon, 17 Mar 2014 10:38:16 +0100")
References: <1394427333-9028-1-git-send-email-dinguyen@altera.com>
 <201403171038.16362.arnd@arndb.de>
Message-ID: <864n2xx9c7.fsf@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, Mar 17 2014, Arnd Bergmann wrote:
> Chris, it would be nice if you could revert d9c3f5df539a "dts: socfpga: Add
> support for SD/MMC on the SOCFPGA platform" in your mmc tree now. The
> commit is now also present in arm-soc where it belongs, and we will get
> a merge conflict if we both carry it, due to the screwup on the
> sysmgr node.

I see, sorry about this.  I've pushed the revert to mmc-next now.

- Chris.
-- 
Chris Ball   <chris@printf.net>   <http://printf.net/>
