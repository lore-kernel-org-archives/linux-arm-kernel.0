From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Jan 2012 09:50:16 +0000
Subject: [PATCH] ARM: EXYNOS: Adds Samsung TRATS board support
In-Reply-To: <000d01ccc381$59fbe660$0df3b320$%kim@samsung.com>
References: <1324624169-16102-1-git-send-email-riverful.kim@samsung.com>
 <088901ccc1dd$deea1e00$9cbe5a00$%kim@samsung.com>
 <CAH9JG2WEcA1BwWq+uovrax5bWvuXaYsGky8D9txymXta7GY8TQ@mail.gmail.com>
 <000d01ccc381$59fbe660$0df3b320$%kim@samsung.com>
Message-ID: <20120103095015.GH2914@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 26, 2011 at 12:49:21PM +0900, HeungJun, Kim wrote:
> If you don't mind, I want to let you know additional information.
> 
> I also agree with Mr.Park.
> 
> Generally in the robot field, the term "machine" means the total things
> including the machinery part and even the brain "board", and the machine
> is more bigger concept.

Some platforms which the kernel runs on are not a 'board' but a set of
boards: a motherboard and a separate CPU card.  So to call these a
'board' is wrong too.

Welcome to the problem: there is not one single term which satisfies
everyone.  The solution: a compromise.

The compromise that has been chosen for the ARM kernel is to call this
stuff 'machines' or 'platforms' - and the exynos stuff has decided to
call it 'machines'.  (Some people have decided to use 'board' in their
directories, which is fine _provided_ there is consistency within that
directory.)

That's actually the _most_ important thing: consistency.  So if a
maintainer has decided to use one way in their directory, that's the
way which rules for that directory.  So, please, get over it - and
don't start a brand new naming scheme in a directory just because you
don't agree with the maintainers opinion.

So, please name the board mach-trats.c as requested by Kukjin (who is
the maintainer for exynos.)
