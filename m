From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 17:44:10 +0800
Subject: [linux-sunxi] [PATCH 07/15] rtc: sun6i: Add support for all known
 variants
In-Reply-To: <20181128093013.24442-9-wens@csie.org>
References: <20181128093013.24442-1-wens@csie.org>
 <20181128093013.24442-9-wens@csie.org>
Message-ID: <CAGb2v669CSQLq+jQPkzn0MH3Avt2tf0vEA4E29epeXrQA4=yww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 5:30 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> There are different variants to the RTC hardware first seen on sun6i
> (A31). The differences we care about in this driver are the clock rate
> for the internal oscillator, prescalers, and the presence of an external
> clock output.
>
> This patch adds support for all the known base compatibles using the
> variants data structure previously introduced.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

This one was from a prior WiP version. Please ignore it.

ChenYu
