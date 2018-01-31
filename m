From: guohanjun@huawei.com (Hanjun Guo)
Date: Wed, 31 Jan 2018 20:45:56 +0800
Subject: [PATCH v3 0/6] 32bit ARM branch predictor hardening
In-Reply-To: <CAGo_u6o8ahJxnXXN-XuHcsa6=LcA=BBbsGOZ-n8Q9+_dYYswjQ@mail.gmail.com>
References: <20180125152139.32431-1-marc.zyngier@arm.com>
 <d95c2261-febe-bb56-da37-5edc1a593cbb@huawei.com>
 <CAGo_u6o8ahJxnXXN-XuHcsa6=LcA=BBbsGOZ-n8Q9+_dYYswjQ@mail.gmail.com>
Message-ID: <e34add95-a672-b76c-1746-e2d9d152624c@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018/1/29 22:58, Nishanth Menon wrote:
> On Mon, Jan 29, 2018 at 5:36 AM, Hanjun Guo <guohanjun@huawei.com> wrote:
> [...]
> 
>> By the way, this patch set just enable branch predictor hardening
>> on arm32 unconditionally, but some of machines (such as wireless
>> network base station) will not be exposed to user to take advantage
>> of variant 2, and those machines will be pretty sensitive for
>> performance, so can we introduce Kconfig or boot option to disable
>> branch predictor hardening as an option?
> 
> I am curious: Have you seen performance degradation with this series?
> If yes, is it possible to share the information?

Sorry for the late reply, the performance data for context switch (CFS)
is about 6%~12% drop (A9 based machine) for the first around test, but
the data is not stable, I need to retest then I will update here.

Thanks
Hanjun
