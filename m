From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 4 Feb 2016 15:39:50 -0800
Subject: [RFC PATCH] ARM: clocksource: make ARM_GLOBAL_TIMER selectable
In-Reply-To: <CAAtXAHcV-9gXcZOX8dzUOBZUwj9M=O4MAsMCJNQYAP+os-D7Tg@mail.gmail.com>
References: <1454610017-25499-1-git-send-email-grygorii.strashko@ti.com>
 <20160204224128.GG4215@xsjsorenbubuntu>
 <CAAtXAHcV-9gXcZOX8dzUOBZUwj9M=O4MAsMCJNQYAP+os-D7Tg@mail.gmail.com>
Message-ID: <20160204233950.GH4215@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-02-04 at 15:14:47 -0800, Moritz Fischer wrote:
> Hi Soeren,
> 
> On Thu, Feb 4, 2016 at 2:41 PM, S?ren Brinkmann
> <soren.brinkmann@xilinx.com> wrote:
> 
> > But with this change the 'if !CPU_FREQ' becomes obsolete.
> I'm confused, could you explain that statement? You don't want people
> accidentally running with GT when CPU_FREQ is on, right?

Correct. But with this Kconfig rework you can just deselect it in
Kconfig. The generic HAVE_GT could always be selected.

	S?ren
