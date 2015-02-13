From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 13 Feb 2015 20:22:54 +0100
Subject: [PATCH 0/7] ARM: berlin: refactor the clock
In-Reply-To: <54DE4391.4080207@gmail.com>
References: <1423845781-7480-1-git-send-email-antoine.tenart@free-electrons.com>
 <20150213173121.GG26475@lunn.ch>
 <20150213191928.20f79ebf@free-electrons.com>
 <54DE4391.4080207@gmail.com>
Message-ID: <20150213192254.GB17976@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >DT bindings of this platform as "unstable", just like the AT91 guys did
> >for their DT bindings
> >(http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/Documentation/arm/Atmel/README#n100) ?
> 
> Sounds like a plan.

So we all seem to agree that we should break backwards compatibility
with the current binding. And we should explicitly document that
things are currently unstable. I would also suggest putting a comment
about being unstable into the .dts files as well. The .dts files are
more visible to potential users than the binding documents.

     Andrew
