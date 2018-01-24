From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 24 Jan 2018 12:32:23 +0800
Subject: [PATCH] clocksource/drivers/timer_sun5i: Fix trailing semicolon
In-Reply-To: <20180123114112.31297-1-luisbg@kernel.org>
References: <20180123114112.31297-1-luisbg@kernel.org>
Message-ID: <CAGb2v66xSTNa=cqoRPGJwU5GO8AJoMKY6TzTV5XZC72VjOZ-MA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 23, 2018 at 7:41 PM, Luis de Bethencourt <luisbg@kernel.org> wrote:
> The trailing semicolon is an empty statement that does no operation.
> Removing it since it doesn't do anything.
>
> Signed-off-by: Luis de Bethencourt <luisbg@kernel.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
