From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 9 Apr 2013 10:00:45 -0600
Subject: [PATCH v4 1/5] drivers: memory: Introduce Marvell EBU Device Bus
 driver
In-Reply-To: <201304091244.07662.arnd@arndb.de>
References: <1365419194-20871-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <201304091140.51839.arnd@arndb.de>
 <20130409103445.GA2268@localhost>
 <201304091244.07662.arnd@arndb.de>
Message-ID: <20130409160045.GA9663@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 09, 2013 at 12:44:07PM +0200, Arnd Bergmann wrote:

> I think it's still reasonable to make it a module, but it might need
> to be one without a module_exit() call to prevent unloading.

Agree, I think it is better to properly handle a broader set of
possible DT's than to have module unloading. The DT is supposed to be
stable..

Jason
