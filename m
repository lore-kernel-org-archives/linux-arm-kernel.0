From: lznuaa@gmail.com (Zhi Li)
Date: Fri, 9 Mar 2018 16:07:47 -0600
Subject: coresight dummy funnel question
In-Reply-To: <CANLsYkzdGSbSSXsCDGUzbYNKHKy7YiWft5JdT5b3RN+aqn+nGQ@mail.gmail.com>
References: <CAHrpEqRwwMRUBGa_BYasiondhQALZtMcZC8tUfUYyuQMN47uoQ@mail.gmail.com>
 <CANLsYkzdGSbSSXsCDGUzbYNKHKy7YiWft5JdT5b3RN+aqn+nGQ@mail.gmail.com>
Message-ID: <CAHrpEqQ8OHKB3gbE6tB0hg-Hz9SCU+wCWsk7QgRwcembvH9aFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 9, 2018 at 12:03 PM, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
> Hi Zhi,
>
> On 7 March 2018 at 08:57, Zhi Li <lznuaa@gmail.com> wrote:
>> Mathieu:
>>
>>            I am working one enable coresight in our SOC.
>>
>>            But our SOC's cluster funnel have not export program interface.
>>            Our cluster included 4 A53.
>>
>>            4 ETM of A53 connect to funnel, which have NOT program
>> interface. Funnel is default enabled.
>>
>>            Do you have suggest how to bypass or use dummy funnel in dts file?
>
> Is the funnel discoverable on the AMBA bus or is it like the original
> version of replicators?

No, No any program interface at all. Look like replicators

best regards
Frank Li

>
>>
>>
>> best regards
>> Frank Li
