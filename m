From: dhowells@redhat.com (David Howells)
Date: Thu, 11 Apr 2013 17:45:25 +0100
Subject: [PATCH 25/26] arm: Don't use create_proc_read_entry() [RFC]
In-Reply-To: <20130411154806.GU10155@atomide.com>
References: <20130411154806.GU10155@atomide.com>
 <20130411132739.32763.82609.stgit@warthog.procyon.org.uk>
 <20130411133058.32763.5466.stgit@warthog.procyon.org.uk>
Message-ID: <13448.1365698725@warthog.procyon.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> wrote:

> Looks like the mach-omap1/pm.c part we can make into
> a debugfs entry as it only contains PM debug data. But
> that we can do after this patch.

If you have a patch to do that, I can substitute it for this one.

David
