From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 8 Aug 2016 23:41:32 +0200
Subject: [PATCHv6] support for AD5820 camera auto-focus coil
In-Reply-To: <20160808080955.GA3182@valkosipuli.retiisi.org.uk>
References: <20160521054336.GA27123@amd> <573FFF51.1000004@gmail.com>
 <20160521105607.GA20071@amd> <574049EF.2090208@gmail.com>
 <20160524090433.GA1277@amd> <20160524091746.GA14536@amd>
 <20160525212659.GK26360@valkosipuli.retiisi.org.uk>
 <20160527205140.GA26767@amd> <20160805102611.GA13116@amd>
 <20160808080955.GA3182@valkosipuli.retiisi.org.uk>
Message-ID: <20160808214132.GB2946@xo-6d-61-c0.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2016-08-08 11:09:56, Sakari Ailus wrote:
> On Fri, Aug 05, 2016 at 12:26:11PM +0200, Pavel Machek wrote:
> > 
> > This adds support for AD5820 autofocus coil, found for example in
> > Nokia N900 smartphone.
> 
> Thanks, Pavel!
> 
> Let's use V4L2_CID_FOCUS_ABSOLUTE, as is in the patch. If we get something
> better in the future, we'll switch to that then.
> 
> I've applied this to ad5820 branch in my tree.

Thanks. If I understands things correctly, both DTS patch and this patch are
waiting in your tree, so we should be good to go for 4.9 (unless some unexpected
problems surface)?

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
