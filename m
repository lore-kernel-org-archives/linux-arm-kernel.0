From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 26 Apr 2016 15:49:24 -0400
Subject: [PATCH arm 1/1] arm: Use _rcuidle tracepoint to allow use from
 idle
In-Reply-To: <20160426194215.GL3715@linux.vnet.ibm.com>
References: <1461617335-22372-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <20160426150031.GP5995@atomide.com>
 <20160426175214.GJ3715@linux.vnet.ibm.com>
 <20160426182939.GO5995@atomide.com>
 <20160426151725.657ae70c@gandalf.local.home>
 <20160426194215.GL3715@linux.vnet.ibm.com>
Message-ID: <20160426154924.0e9b8c71@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Apr 2016 12:42:15 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:


> Given the similarity with the following:
> 
> 	http://lkml.kernel.org/g/20160425171239.GE3874 at linux.vnet.ibm.com
> 
> May I apply your Reviewed-by?
> 

Yep.

-- Steve
