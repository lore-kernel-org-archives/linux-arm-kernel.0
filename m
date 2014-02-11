From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Feb 2014 20:28:55 +0100
Subject: [PATCH 00/12] Versatile Express updates
In-Reply-To: <1392138636-29240-1-git-send-email-pawel.moll@arm.com>
References: <1392138636-29240-1-git-send-email-pawel.moll@arm.com>
Message-ID: <2782419.lfJiZZjaFg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 February 2014 17:10:24 Pawel Moll wrote:
> This series is a set of updates following the infrastructure
> rework and depends on it. It will be finally posted once
> the main series is merged. For the time being I would really
> appreciate feedback and/or (n)acks...
> 

I haven't read the patches yet, but on a general level, do
you think this code can be (or should) be shared with
mach-versatile and mach-realview?

One of the things on my (mid-term) to-do list is to completely
convert those two platforms over to being entirely DT based
and having no board specific code so we can actually delete
the directories along with mach-vexpress. The sysreg part
seems to be almost identical, and I wonder if you have an
overview of what the difference is, if any.

If we are going to share that code, we might want to give it
a different name, as vexpress is just the latest platform
in that line.

	Arnd
