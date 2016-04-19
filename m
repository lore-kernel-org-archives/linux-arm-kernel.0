From: tony@atomide.com (Tony Lindgren)
Date: Tue, 19 Apr 2016 07:54:00 -0700
Subject: [GIT PULL] omap fixes against v4.6-rc2
In-Reply-To: <20160408191854.GZ16484@atomide.com>
References: <20160408191854.GZ16484@atomide.com>
Message-ID: <20160419145400.GC5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [160408 12:22]:
>       ARM: OMAP: Catch callers of revision information prior to it being populated

And this one causes bogus runtime warnings with other SoCs
as reported by Guenter Roeck. I'll revert this and post
an updated pull request shortly.

Regards,

Tony
