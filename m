From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 27 Nov 2014 05:56:21 +0530
Subject: [PATCH 4/8] opp: Introduce APIs to remove OPPs
In-Reply-To: <11530150.5svHxl9OuM@vostro.rjw.lan>
References: <cover.1416910766.git.viresh.kumar@linaro.org>
 <CAKohponz3MsgZNtm1i-aLx8kRRjJwUJjL=B3RE96EiivwXbF2A@mail.gmail.com>
 <CAKohpomKym9dqzQDmS-7ipze4jCYDU4_UN4a36VceHuGezoiVw@mail.gmail.com>
 <11530150.5svHxl9OuM@vostro.rjw.lan>
Message-ID: <CAKohpomz-kekRU7YD8_TYbeVRRs7WmrqLFT0yALxXwFGjwqNOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 November 2014 at 04:02, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> That should work if I'm not mistaken, but I'm wondering if we could
> settle on using one RCU type for this (later, though).

We can convert all call sites to use SRCU then. Once we are sure about it.
