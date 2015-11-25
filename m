From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 24 Nov 2015 16:47:11 -0800
Subject: [PATCH v2 2/2] restrict /dev/mem to idle io memory ranges
In-Reply-To: <CAPcyv4ijWns879DytqUa+=r5hzQ1qzmB83VV6Z16kQNtmHUtbA@mail.gmail.com>
References: <20151124000553.26360.57819.stgit@dwillia2-desk3.jf.intel.com>
 <20151124000604.26360.56945.stgit@dwillia2-desk3.jf.intel.com>
 <20151124142521.e6d23e44a8b2c24c044c2dec@linux-foundation.org>
 <CAPcyv4ijWns879DytqUa+=r5hzQ1qzmB83VV6Z16kQNtmHUtbA@mail.gmail.com>
Message-ID: <20151124164711.0cb9ecdbba2fc729273f3240@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 24 Nov 2015 16:34:19 -0800 Dan Williams <dan.j.williams@intel.com> wrote:

> > IOW, a very good description of the problem-being-solved would help out
> > a lot here...
> 
> I'll fold the eventual result of this discussion into the changelog if
> I can convince you it's worth moving forward.

I'm easily convinced ;) Please let's get all the info into the right
place, make sure it answers the thus-far-asked questions (at least) and
we'll take it from there.

And please do have a think about switching as much as possible over to
runtime-configurability.  Because "please echo foo > /proc" is a heck
of a lot nicer than "please reboot with iomem=" which is a heck of a lot
nicer than "please ask vendor for a new kernel".
