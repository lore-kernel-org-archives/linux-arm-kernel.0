From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Mon, 6 Jul 2015 21:36:12 +0200 (CEST)
Subject: [PATCH 05/18] ARM/gemini/time: Migrate to new 'set-state'
 interface
In-Reply-To: <43f4546a1b6bc8f0d50e3f22fb3cee071c51e157.1436178990.git.viresh.kumar@linaro.org>
References: <cover.1436178990.git.viresh.kumar@linaro.org>
 <43f4546a1b6bc8f0d50e3f22fb3cee071c51e157.1436178990.git.viresh.kumar@linaro.org>
Message-ID: <alpine.LNX.2.00.1507062135190.8223@T520.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 6 Jul 2015, Viresh Kumar wrote:

> Migrate gemini driver to the new 'set-state' interface provided by
> clockevents core, the earlier 'set-mode' interface is marked obsolete
> now.
> 
> This also enables us to implement callbacks for new states of clockevent
> devices, for example: ONESHOT_STOPPED.
> 
> Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
