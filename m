From: john.stultz@linaro.org (John Stultz)
Date: Fri, 16 Jan 2015 11:05:46 -0800
Subject: [PATCH v2 1/2] clocksource: track usage
In-Reply-To: <1421427439-11699-2-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421427439-11699-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1421427439-11699-2-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <CALAqxLUwRirmeZD-ggbq0ryTi4vrT5w3Drfzg3zLxXnmrurOJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 8:57 AM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Track whether the clocksource is enabled or disabled.


So.. this commit message needs work. Why do we care to track the
clocksource enabled/disabled state?

thanks
-john
