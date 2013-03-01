From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 1 Mar 2013 09:45:51 +0800
Subject: [PATCH v9 8/9] usb: chipidea: tell platform layer the ci core
 probe's result
In-Reply-To: <20130228104559.GB22736@arwen.pp.htv.fi>
References: <20130226094234.GC26189@arwen.pp.htv.fi>
 <20130227022202.GA20402@nchen-desktop>
 <20130227121238.GE8016@arwen.pp.htv.fi>
 <20130228031118.GA19387@nchen-desktop>
 <20130228072617.GB6154@arwen.pp.htv.fi>
 <20130228083143.GB19516@nchen-desktop>
 <20130228084933.GG6544@arwen.pp.htv.fi>
 <871uc0yeau.fsf@ashishki-desk.ger.corp.intel.com>
 <20130228100654.GC19516@nchen-desktop>
 <20130228104559.GB22736@arwen.pp.htv.fi>
Message-ID: <20130301014457.GB19324@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 28, 2013 at 12:45:59PM +0200, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Feb 28, 2013 at 06:06:55PM +0800, Peter Chen wrote:
> 
> > For runtime pm disabled, we may had to add some ugly things, like
> > notify core probe fail, and platform layer needs to handle this failed
> > notify.
> 
> Please stop talking about about "notify core probe fail" that will never
> happen. Not today, not ever. Forget that idea.

Of course, it is ugly way, I just thought if it will affect power, eg dvfs,
bus freq if the usb clock is on. Maybe the user will find USB core init fails
case causes runtime power rise, and fix the core init fail bug.

> 
> -- 
> balbi



-- 

Best Regards,
Peter Chen
