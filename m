From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 28 Mar 2014 15:51:27 +0000
Subject: [PATCH 74/75] ARM: l2c: always enable low power modes
In-Reply-To: <CAL_Jsq+vja-BeNfiVnOicFAa+E6jigDfnb5KWWpxZCZ3eGkJiA@mail.gmail.com>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYaK-0007I0-Sm@rmk-PC.arm.linux.org.uk>
 <CAL_Jsq+vja-BeNfiVnOicFAa+E6jigDfnb5KWWpxZCZ3eGkJiA@mail.gmail.com>
Message-ID: <20140328155127.GL7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 28, 2014 at 10:42:54AM -0500, Rob Herring wrote:
> On Fri, Mar 28, 2014 at 10:20 AM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
> > Always enable the L2C low power modes on L2C-310 R3P0 and newer parts.
> 
> I assume you want to squash this with patch 68/75? Or you are still
> debating whether we want to do this or not? Given that it is r3px
> only, that should greatly reduce any chance of breakage to newer
> platforms.

I will eventually - I've kept it separate for the time being to give
more options.  Let's see how people get on with it - it'll be running
through Olof's builder later today, and there's some other people
wanting to take it for a spin.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
