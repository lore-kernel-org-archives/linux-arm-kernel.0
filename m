From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 13 Jun 2012 15:09:44 +0200
Subject: [RFC 3/4] ARM: topology: Update cpu_power according to DT
 information
In-Reply-To: <1339502524-10265-4-git-send-email-vincent.guittot@linaro.org>
References: <1339502524-10265-1-git-send-email-vincent.guittot@linaro.org>
 <1339502524-10265-4-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1339592984.8980.34.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-06-12 at 14:02 +0200, Vincent Guittot wrote:
> +#ifdef CONFIG_OF

That must really be the worst CONFIG_ name ever..
