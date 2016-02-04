From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Thu, 4 Feb 2016 15:14:47 -0800
Subject: [RFC PATCH] ARM: clocksource: make ARM_GLOBAL_TIMER selectable
In-Reply-To: <20160204224128.GG4215@xsjsorenbubuntu>
References: <1454610017-25499-1-git-send-email-grygorii.strashko@ti.com>
 <20160204224128.GG4215@xsjsorenbubuntu>
Message-ID: <CAAtXAHcV-9gXcZOX8dzUOBZUwj9M=O4MAsMCJNQYAP+os-D7Tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Soeren,

On Thu, Feb 4, 2016 at 2:41 PM, S?ren Brinkmann
<soren.brinkmann@xilinx.com> wrote:

> But with this change the 'if !CPU_FREQ' becomes obsolete.
I'm confused, could you explain that statement? You don't want people
accidentally running with GT when CPU_FREQ is on, right?

Patch looks good to me, FWIW:

Acked-by: Moritz Fischer <moritz.fischer@ettus.com>

Moritz
