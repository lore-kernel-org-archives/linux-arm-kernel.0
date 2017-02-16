From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Feb 2017 17:22:59 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: enable pstore configs
In-Reply-To: <20170209205250.GA118863@google.com>
References: <20170209195646.GA39738@beast> <20170209205250.GA118863@google.com>
Message-ID: <4740492.m49jFGWQak@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, February 9, 2017 12:52:50 PM CET Brian Norris wrote:
> It's useful to get testing on these features on various boards (e.g., on
> KernelCI), and (when they're working) the ramoops feature is extremely
> helpful for debugging live systems.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> + ARM folks
> - Linus

Applied to next/defconfig, thanks!

	Arnd
