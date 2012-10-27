From: rajanikanth.hv@linaro.org (Rajanikanth HV)
Date: Sat, 27 Oct 2012 21:30:44 +0530
Subject: [PATCH 1/4] mfd: ab8500: add devicetree support for fuelgauge
In-Reply-To: <508BF8A8.9090206@gmail.com>
References: <1351146654-9110-1-git-send-email-rajanikanth.hv@stericsson.com>
 <1351146654-9110-2-git-send-email-rajanikanth.hv@stericsson.com>
 <508BF8A8.9090206@gmail.com>
Message-ID: <CAB4BAkuPE6eSr2+LWTaV9trOnFk-_yt-+x8f6zpum=Ws1UvmmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 October 2012 20:37, Francesco Lavra <francescolavra.fl@gmail.com> wrote:
> On 10/25/2012 08:30 AM, Rajanikanth H.V wrote:
>> From: "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>
>> +     bat_tech = of_get_property(np_bat_supply,
>> +                     "stericsson,battery-type", NULL);
>> +     if (!bat_tech)
>> +             dev_warn(dev, "missing property battery-name/type\n");
>> +
>> +     if (strncmp(bat_tech, "LION", 4) == 0) {
>
> What if bat_tech is NULL?
It will be UNKNOWN
