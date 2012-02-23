From: tony@atomide.com (Tony Lindgren)
Date: Thu, 23 Feb 2012 11:27:39 -0800
Subject: [PATCH] ARM: OMAP2: fix mailbox init code
In-Reply-To: <CAK=WgbYsV4M6RYYyA85=FyJcEW-8O3yiqZit2ev2AW-mG+0-8A@mail.gmail.com>
References: <1329987215-28227-1-git-send-email-ohad@wizery.com>
 <B5906170F1614E41A8A28DE3B8D12143317AD2B7@DBDE01.ent.ti.com>
 <CAK=WgbYsV4M6RYYyA85=FyJcEW-8O3yiqZit2ev2AW-mG+0-8A@mail.gmail.com>
Message-ID: <20120223192739.GB18185@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ohad Ben-Cohen <ohad@wizery.com> [120223 08:32]:
> On Thu, Feb 23, 2012 at 11:18 AM, Bedia, Vaibhav <vaibhav.bedia@ti.com> wrote:
> > Instead of adding more #ifs can they be completely removed please?
> 
> Care to propose something specific (which is viable for the -rc cycle) ?

This is pretty much the minimal change for -rc cycle so I'll apply
this into fixes.

Regards,

Tony
