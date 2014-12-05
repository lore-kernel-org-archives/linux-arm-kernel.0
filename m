From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 5 Dec 2014 10:54:49 +0530
Subject: [RFC] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <CAKohponP3PXd5b=YY7bpBK6FTNc5_Y7RU=X7q7dP1bYELcW6Dw@mail.gmail.com>
References: <52c403454c3b8fc201abe7ac74cf657638479311.1417691389.git.viresh.kumar@linaro.org>
 <1417692868.9037.4.camel@pengutronix.de>
 <CAKohponP3PXd5b=YY7bpBK6FTNc5_Y7RU=X7q7dP1bYELcW6Dw@mail.gmail.com>
Message-ID: <CAKohpomO1HdoCJPSK8RHYozBhBTxwE4kQLYK48Ub4fFVV0mt-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 December 2014 at 19:37, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> This is not only clock's latency, but is somehow named this way. This should
> give the time it takes to change from frequency A to frequency B, which include
> change in supplies as well.. So, this probably is dvfs-latency ..

Oops. No this is just clock-latency. We are calculating voltage-latency
separately.
