From: cjb@laptop.org (Chris Ball)
Date: Fri, 01 Jul 2011 19:06:54 -0400
Subject: [PATCH v4 0/4] Extend sdhci-esdhc-imx card_detect and
	write_protect support for mx5
In-Reply-To: <20110627042345.GA21757@S2100-06.ap.freescale.net> (Shawn Guo's
	message of "Mon, 27 Jun 2011 12:23:46 +0800")
References: <1308667311-1855-1-git-send-email-shawn.guo@linaro.org>
	<20110627013826.GB21415@S2100-06.ap.freescale.net>
	<m27h88djf6.fsf@bob.laptop.org>
	<20110627042345.GA21757@S2100-06.ap.freescale.net>
Message-ID: <m2liwh4n3l.fsf@bob.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 27 2011, Shawn Guo wrote:
>> I'll need to rebase mmc-next onto linux-next before I can merge it,
>> because the mach-imx/ board files you're modifying do not exist in
>> Linus' tree.  (I don't mind doing that, but it might be easier if
>> you had the ARM patches go in via a different tree instead.)
> 
> I can ask Sascha to pick up patch #4 with your ack.  But the problem
> is patch #4 has to work with #1 applied first, otherwise the CD
> interrupt storm will freeze the system.

Let's do that, please.  I've merged #1-#3 to mmc-next, and for #4:

Acked-by: Chris Ball <cjb@laptop.org>

(Sascha, please note that you'll have to send #4 to Linus after I send
the MMC pull request, as Shawn explains above.)

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
