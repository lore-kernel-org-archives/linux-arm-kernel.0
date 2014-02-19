From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 19 Feb 2014 17:44:59 +0000 (UTC)
Subject: [PATCH 1/1] ARM: OMAP5: Fix reboot handling
In-Reply-To: <alpine.DEB.2.02.1402191738320.8777@utopia.booyaka.com>
References: <1392592544-7884-1-git-send-email-vaibhav.bedia@gmail.com>
 <alpine.DEB.2.02.1402191738320.8777@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.02.1402191744520.8777@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Feb 2014, Paul Walmsley wrote:

> On Sun, 16 Feb 2014, Vaibhav Bedia wrote:
> 
> > Use the correct register offset for issuing the
> > reset command in OMAP5. Since dev_inst is set dynamically
> > OMAP4 should not be affected by this change.
> > 
> > Signed-off-by: Vaibhav Bedia <vaibhav.bedia@gmail.com>
> 
> Thanks, queued for v3.14-rc with Lokesh's Tested-by:.

(and Rajendra's ack also)


- Paul
