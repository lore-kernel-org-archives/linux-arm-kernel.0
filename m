From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 30 Oct 2014 07:55:41 -0400
Subject: [PATCH] tracing/syscalls: ignore numbers outside NR_syscalls'
 range
In-Reply-To: <20141030075223.721e23d6@gandalf.local.home>
References: <1414620418-29472-1-git-send-email-rabin@rab.in>
 <20141030082606.GA7945@infradead.org>
 <20141030101808.GO27405@n2100.arm.linux.org.uk>
 <20141030071039.37633bf5@gandalf.local.home>
 <20141030075223.721e23d6@gandalf.local.home>
Message-ID: <20141030075541.3bbe3609@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 30 Oct 2014 07:52:23 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

 
> Bah, I misread the patch. I shouldn't read patches before having my
> morning coffee :-/
> 

That's what I get by reading email before doing my morning Physical
Therapy treatment.

I'm off to do my PT exercises and then have breakfast. I'll pull the
patch in today, test it out, and then push it off for 3.18-rcX.

Thanks,

-- Steve
