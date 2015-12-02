From: rostedt@goodmis.org (Steven Rostedt)
Date: Wed, 2 Dec 2015 09:02:24 -0500
Subject: [PATCH] arm64: ftrace: stop using kstop_machine to
 enable/disable tracing
In-Reply-To: <20151202123654.GC4523@arm.com>
References: <1448697009-17211-1-git-send-email-huawei.libin@huawei.com>
 <20151202123654.GC4523@arm.com>
Message-ID: <20151202090224.2520dcd5@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2 Dec 2015 12:36:55 +0000
Will Deacon <will.deacon@arm.com> wrote:


> > Cc: <stable@vger.kernel.org> # 3.18+  
> 
> I don't think this is stable material.
> 

No, it definitely isn't. This is a new feature not a fix.

-- Steve
