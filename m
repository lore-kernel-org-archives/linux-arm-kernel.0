From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Jul 2015 15:36:27 +0200
Subject: [PATCH 38/41] clocksource: u300: Migrate to new 'set-state'
 interface
In-Reply-To: <0b64aa9802f9657aae1618e073ac4c0b9de4cfd0.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
 <0b64aa9802f9657aae1618e073ac4c0b9de4cfd0.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <CACRpkdZ7OMi0geNnY4Y4NwrGHKqt+nf0uQpx6wKU4J7Asewn4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 12:54 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> Migrate u300 driver to the new 'set-state' interface provided by
> clockevents core, the earlier 'set-mode' interface is marked obsolete
> now.
>
> This also enables us to implement callbacks for new states of clockevent
> devices, for example: ONESHOT_STOPPED.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
