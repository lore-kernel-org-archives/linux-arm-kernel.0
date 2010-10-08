From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 08 Oct 2010 13:52:26 +0400
Subject: [PATCH] davinci: Implement sched_clock()
In-Reply-To: <87pqvm9bbv.fsf@deeprootsystems.com>
References: <1286354335-31819-1-git-send-email-Andreas.Gaer@baslerweb.com>
	<87pqvm9bbv.fsf@deeprootsystems.com>
Message-ID: <4CAEE9DA.1020900@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07-10-2010 21:12, Kevin Hilman wrote:

>> Overwrite the default implementation of sched_clock that is based on
>> jiffies by something more precise. This improves timestamps in ftrace.
>> Implementation is copied from OMAP platform code.

>> Signed-off-by: Andreas Gaeer<Andreas.Gaer@baslerweb.com>

> Thanks, applying to davinci git.

> Will queue for 2.6.38 (it's a bit too late for 2.6.37 as Linus only
> wants real regression fixes after -rc6.)

    Did you mean 2.6.37 and 2.6.36 respecitvely?

WBR, Sergei
