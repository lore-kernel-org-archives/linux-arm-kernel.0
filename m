From: joe@perches.com (Joe Perches)
Date: Thu, 30 Jan 2014 08:41:16 -0800
Subject: [PATCH v2 6/6] cpu/idle.c: move to sched/idle.c
In-Reply-To: <20140130162753.GF5002@laptop.programming.kicks-ass.net>
References: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org>
 <1391017513-12995-7-git-send-email-nicolas.pitre@linaro.org>
 <20140130152500.GB5002@laptop.programming.kicks-ass.net>
 <alpine.LFD.2.11.1401301102210.1652@knanqh.ubzr>
 <20140130162753.GF5002@laptop.programming.kicks-ass.net>
Message-ID: <1391100076.2422.56.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-01-30 at 17:27 +0100, Peter Zijlstra wrote:
> On Thu, Jan 30, 2014 at 11:03:31AM -0500, Nicolas Pitre wrote:
> > > This is not a valid patch for PATCH(1). Please try again.
> > 
> > Don't you use git?  ;-)
> 
> Nah, git and me don't get along well.

Perhaps you could use a newer version of patch

http://savannah.gnu.org/forum/forum.php?forum_id=7361

GNU patch version 2.7 released

Item posted by Andreas Gruenbacher <agruen> on Wed 12 Sep 2012 02:18:14
PM UTC.

I am pleased to announce that version 2.7 of GNU patch has been
released. The following significant changes have happened since the last
stable release in December 2009: 

      * Support for most features of the "diff --git" format, including
        renames and copies, permission changes, and symlink diffs.
        Binary diffs are not supported yet; patch will complain and skip
        them.
