From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 23 Jan 2013 07:05:32 -0800
Subject: [PATCH V5] drivers/pinctrl: grab default handles from device core
In-Reply-To: <CACRpkdZTwvdmRnDOAcOObj7NhkuUunACpYBvAE1bY65suroQiA@mail.gmail.com>
References: <1358877374-1279-1-git-send-email-swarren@wwwdotorg.org>
 <CACRpkdZTwvdmRnDOAcOObj7NhkuUunACpYBvAE1bY65suroQiA@mail.gmail.com>
Message-ID: <20130123150532.GA2383@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 23, 2013 at 09:50:36AM +0100, Linus Walleij wrote:
> OK!
> 
> This modified version of the patch is way more beautiful, stupid
> me for not realizing it could be written like that.
> 
> And I can sure live with the removed doc piece ... we can discuss
> that separately if need be, I have some argument for it but it's
> a separate issue.
> 
> I've dubbed this version the v5 variant and applied it, and included
> the changelog (so I remember how it came about).
> 
> Greg/Mark: are you still confident with your ACK/Reviewed-by
> tags being added on this version?

Yes, that's fine with me.
