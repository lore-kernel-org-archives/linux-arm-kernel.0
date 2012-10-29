From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Mon, 29 Oct 2012 04:34:33 +0000
Subject: [PATCH] ARM: AM33xx: add support for reboot
In-Reply-To: <508D8537.9010107@gmail.com>
References: <1351448275-23509-1-git-send-email-zonque@gmail.com>
 <508D8537.9010107@gmail.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EBEE8C3@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2012 at 00:49:19, Daniel Mack wrote:
> [Cc Tony]
> 
> On 28.10.2012 19:17, Daniel Mack wrote:
> > This patch adds the ability to reboot am33xx-based systems.
> 
> Sorry, I lacked to investigate on the attribution here. According to
> "git blame" of a BSP kernel I got these lines from, the original author
> is Afzal Mohammed.
> 
> Afzal, are you planning to resubmit this for mainline? My version can of
> course be disposed then.
> 

This should be on top of Paul's recent changes [1] to save him some rework
headache.
 
Regards,
Vaibhav

[1] http://marc.info/?l=linux-omap&m=135120744528680&w=2
