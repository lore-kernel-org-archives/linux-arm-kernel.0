From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 13 Jun 2012 15:19:40 +0200
Subject: [RFC 3/4] ARM: topology: Update cpu_power according to DT
 information
In-Reply-To: <1339502524-10265-4-git-send-email-vincent.guittot@linaro.org>
References: <1339502524-10265-1-git-send-email-vincent.guittot@linaro.org>
 <1339502524-10265-4-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1339593580.8980.35.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-06-12 at 14:02 +0200, Vincent Guittot wrote:
> Use cpu compatibility field and clock-frequency field of DT to
> estimate the capacity of each core of the system
> 
Can you provide a little description in the form of a code comment near
update_cpu_power() as to wtf all that does? This OF nonsense is
unreadable.
