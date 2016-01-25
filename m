From: joe@perches.com (Joe Perches)
Date: Mon, 25 Jan 2016 04:45:01 -0800
Subject: [PATCH 1/3] printk: make preferred_console local static bool
In-Reply-To: <1453722324-22407-2-git-send-email-aleksey.makarov@linaro.org>
References: <1453722324-22407-1-git-send-email-aleksey.makarov@linaro.org>
 <1453722324-22407-2-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <1453725901.28952.53.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-01-25 at 17:45 +0600, Aleksey Makarov wrote:
> The variable preferred_console is used only inside register_console()
> and it's semantics is boolean.??Make it clear.

This loses the index of the preferred console.
I'm not sure this is better.
