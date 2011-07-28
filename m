From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Jul 2011 16:01:34 +0100
Subject: [RFC PATCH 0/3] ARM: Add default system.h and uncompress.h
In-Reply-To: <4E316253.1070601@gmail.com>
References: <1311823934-29553-1-git-send-email-robherring2@gmail.com>
	<20110728095221.GA31473@n2100.arm.linux.org.uk>
	<4E316253.1070601@gmail.com>
Message-ID: <20110728150134.GA11584@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 28, 2011 at 08:21:23AM -0500, Rob Herring wrote:
> On 07/28/2011 04:52 AM, Russell King - ARM Linux wrote:
> > So no, losing that ability is not an option.  Really.
> 
> If a platform has an uncompress.h, then you don't lose anything. Is it
> something that has to *always* be available? Are you opposed to a config
> option here? It can be available only for single arch/machine builds
> similar to DEBUG_LL.
