From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 14 Jun 2016 10:20:40 +0800
Subject: [PATCH 03/10] mfd: Add driver for X-Powers AC100 audio codec /
 RTC combo IC
In-Reply-To: <1465870678-30128-5-git-send-email-wens@csie.org>
References: <1465870678-30128-1-git-send-email-wens@csie.org>
 <1465870678-30128-5-git-send-email-wens@csie.org>
Message-ID: <CAGb2v66_SrKjQ_t_rL68QUVZQ=8hBoCTb8tbwCeBWz84kTabcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14, 2016 at 10:17 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> The AC100 is a multifunction device with an audio codec subsystem and
> an RTC subsystem. These two subsystems share a common register space
> and host interface.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Self-NACK. A last minute fix up resulted in a compile error.

I'll send v2 later. Sorry for the noise.

Regards
ChenYu
