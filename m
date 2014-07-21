From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 21 Jul 2014 05:57:49 +0530
Subject: [PATCH 1/2] PCI: spear: Fix Section mismatch compilation warning
 for probe()
In-Reply-To: <CAOesGMi0HgL14zMqALvqT_cGMr13mGSN0O493eLmydt8Dscqug@mail.gmail.com>
References: <76576b662613369d0c71db30ceed4ed5ae1343d2.1405857442.git.viresh.kumar@linaro.org>
 <20140720192649.GA30124@quad.lixom.net>
 <CAKohpokOJLKOwB_rKz0W-1T0nYX7-2_8nm3wQr6khR55x4gqrA@mail.gmail.com>
 <CAOesGMi0HgL14zMqALvqT_cGMr13mGSN0O493eLmydt8Dscqug@mail.gmail.com>
Message-ID: <CAKohpon8mGbZ+jEPLmpKeUrxXBfXaXJAAemi8j-jhiHVJbwxRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 July 2014 05:51, Olof Johansson <olof@lixom.net> wrote:
> Oh, sorry, I got distracted by my kid waking up so the email was a bit short. :)

I can understand, mine is 14 months :)

> The easiest way of doing it is to switch to 12 by default. In your .gitconfig:
>
> [core]
>         abbrev = 12

Oh, that will be extremely useful. Thanks.
