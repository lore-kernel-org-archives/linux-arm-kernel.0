From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 1 Dec 2014 20:18:43 +0530
Subject: [RFC V1 0/8] CPUFreq: create platform-dev for DT based cpufreq
 drivers
In-Reply-To: <23115535.r6kXsReHU2@wuerfel>
References: <cover.1417433163.git.viresh.kumar@linaro.org>
 <CAKohpo=EPOH-WJ4mmAr-1BzzAEpvC-F0Y99Ox_yL7meUcRNx6Q@mail.gmail.com>
 <547C6E9D.2090205@arm.com> <23115535.r6kXsReHU2@wuerfel>
Message-ID: <CAKohpo=xDrizL5+5zeVAj_x1BhMuidCa8Ed90YOQbzSTQ_yb2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 December 2014 at 19:41, Arnd Bergmann <arnd@arndb.de> wrote:
> I would prefer the /cpus node over the /chosen node because the former
> describes the hardware while the latter is supposed to be user-settable
> (on real open-firmware at least). But I think either one is better than
> using the / node compatible string.
>
> How about a "linux,cpu-dvfs-method" property in the root node? Would
> that work better for you than a "linux,dvfs-method" in the "/cpus"
> node?

I will choose "linux,dvfs-method" in the "/cpus" node.
