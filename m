From: sameo@linux.intel.com (Samuel Ortiz)
Date: Wed, 19 Sep 2012 18:03:02 +0200
Subject: [rtc-linux] [PATCH 1/1] drivers/rtc/rtc-ab8500.c: Revoke Device
 Tree enablement
In-Reply-To: <CACRpkdbXwLXoWL+PS-wJ9cbztC-jWhyc=vr+98ffg70f6coaiQ@mail.gmail.com>
References: <1344527828-6283-1-git-send-email-lee.jones@linaro.org>
 <1344527828-6283-3-git-send-email-lee.jones@linaro.org>
 <CACRpkdZa-72QogrZ-P5jbDHTTX64babZo3ydjzfgC-4LWUBfMg@mail.gmail.com>
 <20120831110818.GA5962@gmail.com>
 <CACRpkdat3zj_47r7ENz7Qv3N8cNOSKDV+k5em9DjOhkNycy9gQ@mail.gmail.com>
 <CACRpkdbXwLXoWL+PS-wJ9cbztC-jWhyc=vr+98ffg70f6coaiQ@mail.gmail.com>
Message-ID: <20120919160302.GN28670@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Sat, Sep 01, 2012 at 01:28:34AM +0200, Linus Walleij wrote:
> On Sat, Sep 1, 2012 at 1:27 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Fri, Aug 31, 2012 at 1:08 PM, Lee Jones <lee.jones@linaro.org> wrote:
> >> On Tue, Aug 14, 2012 at 10:32:02AM +0200, Linus Walleij wrote:
> >>> On Thu, Aug 9, 2012 at 5:57 PM, Lee Jones <lee.jones@linaro.org> wrote:
> >>>
> >>> > All AB8500 devices are now registered via MFD core, so Device Tree
> >>> > capability is no longer required for probing. Here we pull the DT
> >>> > match table to ensure we're no longer probed during Device Tree
> >>> > start-up.
> >>> >
> >>> > CC: Alessandro Zummo <a.zummo@towertech.it>
> >>> > CC: rtc-linux at googlegroups.com
> >>> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >>>
> >>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >>
> >> I'm guessing we still need Alessandro's Ack?
> >
> > Well, usually we have Andrew Morton merging patches for RTC, so
> > put him on CC.
> >
> > If I was the MFD maintainer I'd just merge this though, it's quite
> > obvious.
> >
> > Sam: do you agree?
I'd love to see the patch first :)
Could you please bounce it to me ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
