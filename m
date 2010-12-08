From: tony@atomide.com (Tony Lindgren)
Date: Tue, 7 Dec 2010 17:04:35 -0800
Subject: [PATCH 12/11] omap1: Fix gpio mpuio bank to work for
	multi-omap for 7xx/15xx/16xx
In-Reply-To: <20101207232315.GE17435@atomide.com>
References: <1290689318-10191-1-git-send-email-charu@ti.com>
	<20101201183357.GI17222@atomide.com>
	<87zkso4hu3.fsf@deeprootsystems.com>
	<AANLkTinY8FKbVvXD29KpgGnsnKwQziXws+zKLZWn69Hj@mail.gmail.com>
	<20101204212554.GM17222@atomide.com>
	<20101207232315.GE17435@atomide.com>
Message-ID: <20101208010434.GH17435@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [101207 15:13]:
> 
> Note that this will cause omap-keypad.c driver to not work on 7xx.
> However, the right fix there is to move over to gpio-keys instead as
> suggested by Cory Maccarrone <darkstar6262@gmail.com> and
> Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>.

Updated that to say matrix-keypad instead of gpio-keys as pointed
out by Janusz.

Tony 
