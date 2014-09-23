From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 23 Sep 2014 17:15:09 +0200
Subject: [PATCH] atomic_read: Use ACCESS_ONCE() instead of cast to volatile
In-Reply-To: <1411482607-20948-1-git-send-email-bobby.prani@gmail.com>
References: <1411482607-20948-1-git-send-email-bobby.prani@gmail.com>
Message-ID: <20140923151509.GI3312@worktop.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 23, 2014 at 10:29:50AM -0400, Pranith Kumar wrote:
> Use the much reader friendly ACCESS_ONCE() instead of the cast to volatile. This
> is purely a style change.
> 
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>

Looks good to me; I can route it through the locking tree if there's no
objections.
