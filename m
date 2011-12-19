From: lauri.hintsala@bluegiga.com (Lauri Hintsala)
Date: Mon, 19 Dec 2011 09:13:16 +0200
Subject: [PATCH v3] ARM: mxs: Add initial support for Bluegiga APX4
 Development Kit
In-Reply-To: <20111219071350.GH4962@S2100-06.ap.freescale.net>
References: <1323766966-30502-1-git-send-email-lauri.hintsala@bluegiga.com>
 <20111219071350.GH4962@S2100-06.ap.freescale.net>
Message-ID: <4EEEE40C.3000200@bluegiga.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/2011 09:13 AM, Shawn Guo wrote:
> The patch looks good.

Thank you for your time.


> The only problem I have is I do not see MACH_TYPE_APX4DEVKIT defined
> in arch/arm/tools/mach-types on either Linus' tree or linux-next
> tree.  I'm afraid that we will experience the same problem we have
> experienced with m28evk patch, which broke the whole mxs build for a
> couple of early -rc of v3.2.

I see the problem. What is your suggestion? Should we create patch to 
add APX4DEVKIT to mach-types file as you did last time?
http://permalink.gmane.org/gmane.linux.ports.arm.kernel/140425

We have register apx4devkit to ARM machine database. Machine id of 
apx4devkit is 3712. For some reason "Kconfig macro" and "type 
identifier" are out of sync in db. DEVKIT string is missing from those.
http://www.arm.linux.org.uk/developer/machines/list.php?id=3712


BR,
Lauri
