From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 31 Jan 2017 22:04:29 +0100
Subject: [PATCH] rtc: snvs: add a missing write sync
In-Reply-To: <1485683839-8843-1-git-send-email-guy.shapiro@mobi-wize.com>
References: <1485683839-8843-1-git-send-email-guy.shapiro@mobi-wize.com>
Message-ID: <20170131210429.zoh75tcr4ymvsw6o@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/01/2017 at 11:57:19 +0200, Guy Shapiro wrote:
> The clear of the LPTA_EN flag should be synced before writing to the
> alarm register. Omitting this synchronization creates a race when
> trying to change existing alarm.
> 
> Signed-off-by: Guy Shapiro <guy.shapiro@mobi-wize.com>
> ---
>  drivers/rtc/rtc-snvs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
