From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 6 Nov 2012 09:59:31 +0100
Subject: [PATCH v2 1/2] mailbox: OMAP: introduce mailbox framework
In-Reply-To: <CACRpkdb0nCaV5L5xCnzje3w=t7+TZpcvCCUDRPi-10t+oF8UGg@mail.gmail.com>
References: <1352170552-29564-1-git-send-email-omar.luna@linaro.org>
 <1352170552-29564-2-git-send-email-omar.luna@linaro.org>
 <509886A2.5060509@wwwdotorg.org>
 <CACRpkdb0nCaV5L5xCnzje3w=t7+TZpcvCCUDRPi-10t+oF8UGg@mail.gmail.com>
Message-ID: <20121106085931.GA26335@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2012 at 09:55:52AM +0100, Linus Walleij wrote:
> On Tue, Nov 6, 2012 at 4:40 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> 
> > Is this a public interface to the driver? If so, shouldn't the header be
> > in include/linux somewhere?
> 
> I think the split out of the public header is done in patch 2/2.

Yes, but the names are still omap_*, which doesn't make much sense here.

greg k-h
