From: nm@ti.com (Menon, Nishanth)
Date: Thu, 16 Feb 2012 12:14:16 -0600
Subject: [PATCH 6/6] arm: omap: pm-debug: enhanced usecount debug support
In-Reply-To: <87y5s2hebb.fsf@ti.com>
References: <1329237402-26008-1-git-send-email-t-kristo@ti.com>
 <1329237402-26008-7-git-send-email-t-kristo@ti.com>
 <20120214202740.GT1426@atomide.com>
 <87fwed58dm.fsf@ti.com> <20120214235218.GX1426@atomide.com>
 <1329294866.4102.343.camel@sokoban> <874nus5djf.fsf@ti.com>
 <CAOMWX4cg4mfBQGcHLodjFaVY0vVGnKJKvsa9ngMLO-0Ca7gBTQ@mail.gmail.com>
 <87y5s2hebb.fsf@ti.com>
Message-ID: <CAOMWX4di8HN=jk7MPVnusYfdYbC5Nj24trNuiy9paGvYFgbtgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2012 at 11:35, Kevin Hilman <khilman@ti.com> wrote:
>
>>> IMO, the one thing we're still missing is the ability to take register
>>> snapshots (like immediately before and after WFI) and somehow feed those
>>> to omapconf for deciphering.
>>>
>> Something like this perhaps?
>> https://github.com/nmenon/linux-omap-ti-pm/commit/3cd1994fc0df9a8e3e0be74ec3f3add3ff3aef95
>
> Yes, although that is targetted pretty narrowly at suspend and only PRM
> registers.
>
> Do you then use omapconf to display the results?
on the platform we worked on, not everyone had access to omapconf, it
was just 'cat' to take the dump.
omapconf support makes sense if this is a consistent interface cross
OMAP variants, even better if a similar
framework is available cross SoCs.

Regards,
Nishanth Menon
