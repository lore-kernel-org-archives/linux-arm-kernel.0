From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 17 Jun 2014 12:26:24 +0100
Subject: [PATCH RFCv2 1/5] ARM: use write allocate by default on ARMv6+
In-Reply-To: <20140617104854.7393c14c@free-electrons.com>
References: <20140527121806.GF3693@n2100.arm.linux.org.uk>
 <20140527143745.386c77d9@free-electrons.com>
 <20140528112450.GH3693@n2100.arm.linux.org.uk>
 <20140530100819.1208149f@free-electrons.com>
 <20140530092044.GO3693@n2100.arm.linux.org.uk>
 <20140613121121.7e7dc8e6@free-electrons.com>
 <20140613102019.GQ23430@n2100.arm.linux.org.uk>
 <20140613133437.1a85f287@free-electrons.com>
 <20140613155139.05e2393c@free-electrons.com>
 <20140617104854.7393c14c@free-electrons.com>
Message-ID: <20140617112624.GI23430@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 10:48:54AM +0200, Thomas Petazzoni wrote:
> Russell,
> 
> Do you have some input/feedback about the below proposals/questions?

Not at the moment, I'm busy sorting through the 150-odd months-old
patches which remain in my tree post-merge window, working through
regressions, and trying to sort them out so I can (re-)post them and
hopefully get rid of them.

Of course, if it didn't take many months to get patches into mainline,
then I wouldn't be doing this right now, and I could spend more time
thinking more about these sorts of issues, rather than (eg) thinking
about how to generate DT binding documentation for drivers which have
been merged without that required documentation, which I then need to
modify, and then promptly get asked to write that required documentation
for.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
