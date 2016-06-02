From: simon.marchi@ericsson.com (Simon Marchi)
Date: Thu, 2 Jun 2016 09:17:02 -0400
Subject: Possible race between PTRACE_SETVFPREGS and PTRACE_CONT on ARM?
In-Reply-To: <20160602131539.GA30141@n2100.armlinux.org.uk>
References: <574C7CDB.7050103@ericsson.com>
 <20160530213529.GS19428@n2100.arm.linux.org.uk>
 <574EDAED.1050902@ericsson.com>
 <20160602131539.GA30141@n2100.armlinux.org.uk>
Message-ID: <575031CE.2080300@ericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16-06-02 09:15 AM, Russell King - ARM Linux wrote:
> Hi, can I add a:
> 
> Tested-by: Simon Marchi <simon.marchi@ericsson.com>
> 
> tag to the commit please?

Yes, of course.
