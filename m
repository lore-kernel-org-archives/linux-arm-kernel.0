From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 9 Mar 2018 11:03:39 -0700
Subject: coresight dummy funnel question
In-Reply-To: <CAHrpEqRwwMRUBGa_BYasiondhQALZtMcZC8tUfUYyuQMN47uoQ@mail.gmail.com>
References: <CAHrpEqRwwMRUBGa_BYasiondhQALZtMcZC8tUfUYyuQMN47uoQ@mail.gmail.com>
Message-ID: <CANLsYkzdGSbSSXsCDGUzbYNKHKy7YiWft5JdT5b3RN+aqn+nGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zhi,

On 7 March 2018 at 08:57, Zhi Li <lznuaa@gmail.com> wrote:
> Mathieu:
>
>            I am working one enable coresight in our SOC.
>
>            But our SOC's cluster funnel have not export program interface.
>            Our cluster included 4 A53.
>
>            4 ETM of A53 connect to funnel, which have NOT program
> interface. Funnel is default enabled.
>
>            Do you have suggest how to bypass or use dummy funnel in dts file?

Is the funnel discoverable on the AMBA bus or is it like the original
version of replicators?

>
>
> best regards
> Frank Li
