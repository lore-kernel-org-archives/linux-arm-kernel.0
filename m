From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Jan 2010 17:41:18 +0000
Subject: "init_task" belongs to "swapper" or "init" ?
In-Reply-To: <cf70f0211001040935g57ccd2bemc41b40d83486130f@mail.gmail.com>
References: <cf70f0211001040935g57ccd2bemc41b40d83486130f@mail.gmail.com>
Message-ID: <20100104174118.GD14533@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2010 at 09:35:06AM -0800, Shivdas Gujare wrote:
> Hi all,
> 
> I am trying to understand the role of linux kernel "process 0" i.e. swapper.
> I am not able to understand, where it gets started? and Does
> "init_task" from arch/arm/kernel/init_task.c belongs to "swapper" or "init"?
> whats the purpose of "init_task"?

swapper.  It's what gets run when there's nothing else to run.
