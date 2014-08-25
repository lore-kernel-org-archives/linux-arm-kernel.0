From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 25 Aug 2014 15:39:55 +0200
Subject: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <20140825124410.GZ15297@lukather>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <1407914239-12054-5-git-send-email-libv@skynet.be>
 <53EB9471.3090204@wwwdotorg.org> <20140813170106.GT15297@lukather>
 <20140825121228.GB4163@ulmo.nvidia.com>
 <20140825124410.GZ15297@lukather>
Message-ID: <20140825133953.GJ4163@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 25, 2014 at 02:44:10PM +0200, Maxime Ripard wrote:
> On Mon, Aug 25, 2014 at 02:12:30PM +0200, Thierry Reding wrote:
> > On Wed, Aug 13, 2014 at 07:01:06PM +0200, Maxime Ripard wrote:
> > > On Wed, Aug 13, 2014 at 10:38:09AM -0600, Stephen Warren wrote:
> > [...]
> > > > If not, perhaps the clock driver should force the clock to be
> > > > enabled (perhaps only if the DRM/KMS driver isn't enabled?).
> > > 
> > > I'm sorry, but I'm not going to take any code that will do that in our
> > > clock driver.
> > > 
> > > I'm not going to have a huge list of ifdef depending on configuration
> > > options to know which clock to enable, especially when clk_get should
> > > have the consumer device as an argument.
> > 
> > Are you saying is that you want to solve a platform-specific problem by
> > pushing code into simple, generic drivers so that your platform code can
> > stay "clean"?
> 
> Are you saying that this driver would become "dirty" with such a patch?

Yes. Others have said the same and even provided alternative solutions
on how to solve what's seemingly a platform-specific problem in a
platform-specific way.

> If so, we really have an issue in the kernel.

Can you elaborate?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140825/68317adf/attachment.sig>
