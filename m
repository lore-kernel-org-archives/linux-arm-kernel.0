From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 16 Aug 2016 14:04:15 +0200
Subject: [PATCH v2] Added perf functionality to mmdc driver
In-Reply-To: <20160815165050.GB31080@svinekod>
References: <20160815223035.5429-1-zhengyu.shen@nxp.com>
 <20160815165050.GB31080@svinekod>
Message-ID: <20160816120415.GJ30192@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 15, 2016 at 05:50:50PM +0100, Mark Rutland wrote:
> For the Nth time, I'm going to say that really, we should have the core check
> this (or expose helpers to do so). It's somewhat ridiculous that evry driver
> has to blacklist everything it doesn't support, rather than whitelisting the
> few things that it does.

I'll look at patches ;-)
