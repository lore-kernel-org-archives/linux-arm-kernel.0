From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 19 Aug 2013 12:19:03 +0530
Subject: [PATCH V2 01/35] cpufreq: Implement light weight ->target_index()
 routine
In-Reply-To: <CADGdYn4q+13xkkF-TeFJ2-H27o9ArQETmgVNEoV_o9YzA0ebDw@mail.gmail.com>
References: <cover.1376392602.git.viresh.kumar@linaro.org>
 <eb988fc9e72b90b7ba99f16405f5dcb072da7840.1376392602.git.viresh.kumar@linaro.org>
 <CADGdYn4=si46x7b5Qa0EJ1vUDKrP3maXBqWwQ6s7gkep-8MxFg@mail.gmail.com>
 <CAKohpokeJZq5Y9PpQCiEqVFqZq0U266rqLEQeEh4ZszWEM6_XA@mail.gmail.com>
 <CADGdYn4LoFEfZTd2bT=iGKRb5M=7CfpG-suxf3L-V5HXH7QuPQ@mail.gmail.com>
 <CAKohpo=HvR9_6DvhhPV0JcBnkmF5bc0pbCQrF7sk=FKOayhcRA@mail.gmail.com>
 <CADGdYn4q+13xkkF-TeFJ2-H27o9ArQETmgVNEoV_o9YzA0ebDw@mail.gmail.com>
Message-ID: <CAKohpok2m-jwrCL7L3eteBx_Ra+P88e04Xab53bnn-2-5DopNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 August 2013 12:16, amit daniel kachhap <amit.daniel@samsung.com> wrote:
> Actually target index will still be re-calculated if the platform
> target driver wants to retrieve the index from the valid frequency or
> directly set the valid frequency in the clock controller. So I wanted
> a simpler/quicker cpufreq_frequency_table_target which just returns
> the matching index from the valid frequency.

I am so sorry but I am still missing your point.

Index isn't required to be calculated by platform drivers anymore, it will be
done by cpufreq core before calling target_index()..
