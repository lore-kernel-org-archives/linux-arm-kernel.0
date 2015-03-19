From: cl@linux.com (Christoph Lameter)
Date: Thu, 19 Mar 2015 11:20:53 -0500 (CDT)
Subject: [PATCH v2] ring-buffer: Replace this_cpu_*() with __this_cpu_*()
In-Reply-To: <20150317110750.2a0e2b73@gandalf.local.home>
References: <20150316173154.537b80ee@gandalf.local.home>
 <alpine.DEB.2.11.1503170049300.9309@gentwo.org>
 <20150317081341.0f9a8b4c@gandalf.local.home>
 <20150317101113.32f5618a@gandalf.local.home>
 <20150317104038.312e73d1@gandalf.local.home>
 <20150317144701.GJ10068@pengutronix.de>
 <20150317110750.2a0e2b73@gandalf.local.home>
Message-ID: <alpine.DEB.2.11.1503191120310.26866@gentwo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Mar 2015, Steven Rostedt wrote:

> Christoph, you happy with this version?

Yes looks good.

Acked-by: Christoph Lameter <cl@linux.com>
