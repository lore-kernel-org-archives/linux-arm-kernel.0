From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 08 Mar 2010 10:27:58 +0000
Subject: Cleanup ARM platform support, and add Versatile Express support
In-Reply-To: <20100305095413.GA3897@n2100.arm.linux.org.uk>
References: <20100305095413.GA3897@n2100.arm.linux.org.uk>
Message-ID: <1268044078.14199.28.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Fri, 2010-03-05 at 09:54 +0000, Russell King - ARM Linux wrote:
> What follows is a rather large patch set (tested by others and myself)
> which cleans up the Integrator, Versatile and Realview platform support,
> and adds support for the ARM Versatile Express platform.

Rather than sending an e-mail to every individual patch, I'll just
comment here on the series. I welcome the Integrator/Versatile/RealView
clean-up and the patches look fine. For these (*except* the Versatile
Express patches):

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

(you don't actually need to go back and add the ack to the patches).

Regarding the choice of the plat-versatile name for the common directory
I don't think it's something that should prevent merging (I'm personally
ok with this but it could be easily changed at a later time).

Regarding the VE patches, since I haven't done the port I cannot
actually tell whether there is something missing. I'll let Colin comment
on them.

-- 
Catalin
