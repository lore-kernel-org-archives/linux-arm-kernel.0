From: john.stultz@linaro.org (John Stultz)
Date: Thu, 14 May 2015 10:02:18 -0700
Subject: [PATCH] time: Remove nonexistent function prototype.
In-Reply-To: <1428674150-1780-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1428674150-1780-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <CALAqxLW0He0JLs1K7fB+QAsjZRaYaJKXTbqVY0+ORa8MOMhqvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 10, 2015 at 6:55 AM, Yingjoe Chen <yingjoe.chen@mediatek.com> wrote:
> The function clocksource_get_next() was removed in commit 75c5158f70
> (timekeeping: Update clocksource with stop_machine), but the
> prototype is not removed with it. Remove the prototype.
>
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>

Queued for 4.2. Thanks for sending this in!
-john
