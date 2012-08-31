From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 31 Aug 2012 12:08:22 +0100
Subject: [rtc-linux] [PATCH 1/1] drivers/rtc/rtc-ab8500.c: Revoke Device
 Tree enablement
In-Reply-To: <CACRpkdZa-72QogrZ-P5jbDHTTX64babZo3ydjzfgC-4LWUBfMg@mail.gmail.com>
References: <1344527828-6283-1-git-send-email-lee.jones@linaro.org>
 <1344527828-6283-3-git-send-email-lee.jones@linaro.org>
 <CACRpkdZa-72QogrZ-P5jbDHTTX64babZo3ydjzfgC-4LWUBfMg@mail.gmail.com>
Message-ID: <20120831110818.GA5962@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 14, 2012 at 10:32:02AM +0200, Linus Walleij wrote:
> On Thu, Aug 9, 2012 at 5:57 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > All AB8500 devices are now registered via MFD core, so Device Tree
> > capability is no longer required for probing. Here we pull the DT
> > match table to ensure we're no longer probed during Device Tree
> > start-up.
> >
> > CC: Alessandro Zummo <a.zummo@towertech.it>
> > CC: rtc-linux at googlegroups.com
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

I'm guessing we still need Alessandro's Ack?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
