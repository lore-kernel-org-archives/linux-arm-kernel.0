From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Wed, 10 Aug 2016 15:00:32 +0300
Subject: [PATCHv6] support for AD5820 camera auto-focus coil
In-Reply-To: <20160810073403.GB30047@pali>
References: <573FFF51.1000004@gmail.com> <20160521105607.GA20071@amd>
 <574049EF.2090208@gmail.com> <20160524090433.GA1277@amd>
 <20160524091746.GA14536@amd>
 <20160525212659.GK26360@valkosipuli.retiisi.org.uk>
 <20160527205140.GA26767@amd> <20160805102611.GA13116@amd>
 <20160808080955.GA3182@valkosipuli.retiisi.org.uk>
 <20160810073403.GB30047@pali>
Message-ID: <20160810120032.GO3182@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2016 at 09:34:03AM +0200, Pali Roh?r wrote:
> On Monday 08 August 2016 11:09:56 Sakari Ailus wrote:
> > On Fri, Aug 05, 2016 at 12:26:11PM +0200, Pavel Machek wrote:
> > > 
> > > This adds support for AD5820 autofocus coil, found for example in
> > > Nokia N900 smartphone.
> > 
> > Thanks, Pavel!
> > 
> > Let's use V4L2_CID_FOCUS_ABSOLUTE, as is in the patch. If we get something
> > better in the future, we'll switch to that then.
> 
> Ok, and what with AD5820_RAMP_TIME and AD5820_RAMP_MODE?
> 
> > I've applied this to ad5820 branch in my tree.
> 
> Are you going to finally send this patch to media tree or pull request
> to Linus?

That'll be through media-tree.

-- 
Sakari Ailus
e-mail: sakari.ailus at iki.fi	XMPP: sailus at retiisi.org.uk
