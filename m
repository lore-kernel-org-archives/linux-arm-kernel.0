From: carlo@caione.org (Carlo Caione)
Date: Sat, 20 Jun 2015 08:53:29 +0200
Subject: [PATCH 09/41] clocksource: meson6: Migrate to new 'set-state'
 interface
In-Reply-To: <31c070cb211232dbe5f03f7afa62ac27d65481ba.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
 <31c070cb211232dbe5f03f7afa62ac27d65481ba.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <CAOQ7t2bMHdk6e-+km8R15e6QPa0bFJY2bAQw6SX+qi3_H0AXYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 12:54 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Migrate meson6 driver to the new 'set-state' interface provided by
> clockevents core, the earlier 'set-mode' interface is marked obsolete
> now.
>
> This also enables us to implement callbacks for new states of clockevent
> devices, for example: ONESHOT_STOPPED.
>
> Cc: Carlo Caione <carlo@caione.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/clocksource/meson6_timer.c | 50 ++++++++++++++++++++------------------
>  1 file changed, 27 insertions(+), 23 deletions(-)

Acked-by: Carlo Caione <carlo@caione.org>

-- 
Carlo Caione
