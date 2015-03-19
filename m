From: cl@linux.com (Christoph Lameter)
Date: Thu, 19 Mar 2015 11:19:56 -0500 (CDT)
Subject: [RFC][PATCH] ring-buffer: Replace this_cpu_{read,write} with
 this_cpu_ptr()
In-Reply-To: <20150317101113.32f5618a@gandalf.local.home>
References: <20150316173154.537b80ee@gandalf.local.home>
 <alpine.DEB.2.11.1503170049300.9309@gentwo.org>
 <20150317081341.0f9a8b4c@gandalf.local.home>
 <20150317101113.32f5618a@gandalf.local.home>
Message-ID: <alpine.DEB.2.11.1503191119350.26866@gentwo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Mar 2015, Steven Rostedt wrote:

> I test this out with __this_cpu_* versions and see if that solves it
> too. If it does, I'll use that version instead.

Yeah that may be best. Sorry for the delay. Stuck at yet another
conference.
