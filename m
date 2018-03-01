From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 1 Mar 2018 14:28:30 +0100
Subject: [PATCH v8 00/15] Krait clocks + Krait CPUfreq
In-Reply-To: <1519740422-3835-1-git-send-email-sricharan@codeaurora.org>
References: <1519740422-3835-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <CACRpkdbu9Kxvuwr-nLHxyEYiTeGK38o7MKCFf-MMjYxwgcJPPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sricharan,

thanks for picking up Stephen's patch set and working on this
clocking business!

Would you happen to know if the MSM8660/APQ8060 that
I'm using a bit has the same Krait clocking so I need to augment
that SoC to use this too (on top of this, naturally, this is a good first
step)?

On Tue, Feb 27, 2018 at 3:06 PM, Sricharan R <sricharan@codeaurora.org> wrote:

>   * Dropped the DT update from the series. Will send separately

Are these available somewhere so I can test the sum total on
the Nexus 7 and see if I get some graphics? I've been sticking a
patch from Stephen's series in for some time and it makes the
MDP graphics works on the 2013 Nexus 7.

Yours,
Linus Walleij
