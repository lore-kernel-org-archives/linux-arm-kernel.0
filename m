From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 16 Dec 2012 17:10:36 +0530
Subject: [PATCH 2/3] CLK: uninline clk_prepare_enable() and
 clk_disable_unprepare()
In-Reply-To: <1353403339-11679-3-git-send-email-dmitry.torokhov@gmail.com>
References: <1353403339-11679-1-git-send-email-dmitry.torokhov@gmail.com>
 <1353403339-11679-3-git-send-email-dmitry.torokhov@gmail.com>
Message-ID: <CAKohpomA=vSGuKfD-_zwiSnXGkqAQjtiVqxT2Po=D-LDA_FESg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 November 2012 14:52, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> We'll need to invoke clk_disable_unprepare() via a pointer in our devm_*
> conversion so let's uninline the pair.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Mike, are you taking these patches?
