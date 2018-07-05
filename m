From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 5 Jul 2018 19:23:06 +0200
Subject: [PATCHv3 08/12] atomics: switch to generated fallbacks
In-Reply-To: <20180705164053.10073-9-mark.rutland@arm.com>
References: <20180705164053.10073-1-mark.rutland@arm.com>
 <20180705164053.10073-9-mark.rutland@arm.com>
Message-ID: <20180705172306.GG2494@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 05, 2018 at 05:40:49PM +0100, Mark Rutland wrote:

> * The fallbacks are not expected to change very often, and are not
>   affected by machine details or configuration options, so regenerating
>   them for *every* build is somewhat wasteful.

Except of course, your last patch in this series now does exactly that
:-)
