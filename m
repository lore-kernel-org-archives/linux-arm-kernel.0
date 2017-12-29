From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Fri, 29 Dec 2017 11:38:55 +0200
Subject: v4.15: camera problems on n900
In-Reply-To: <20171228202453.GA20142@amd>
References: <20171227210543.GA19719@amd>
 <20171227211718.favif66afztygfje@kekkonen.localdomain>
 <20171228202453.GA20142@amd>
Message-ID: <20171229093855.hz44vpssb5mufzop@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 28, 2017 at 09:24:53PM +0100, Pavel Machek wrote:
> On Wed 2017-12-27 23:17:19, Sakari Ailus wrote:
> > On Wed, Dec 27, 2017 at 10:05:43PM +0100, Pavel Machek wrote:
> > > Hi!
> > > 
> > > In v4.14, back camera on N900 works. On v4.15-rc1.. it works for few
> > > seconds, but then I get repeated oopses.
> > > 
> > > On v4.15-rc0.5 (commit ed30b147e1f6e396e70a52dbb6c7d66befedd786),
> > > camera does not start.	  
> > > 
> > > Any ideas what might be wrong there?
> > 
> > What kind of oopses do you get?
> 
> Hmm. bisect pointed to commit that can't be responsible.... Ideas
> welcome.

Hi Pavel,

I tested N9 and capture appears to be working from the CSI-2 receiver
(media tree master, i.e. v4.15-rc3 now).

Which pipeline did you use?

-- 
Regards,

Sakari Ailus
e-mail: sakari.ailus at iki.fi
