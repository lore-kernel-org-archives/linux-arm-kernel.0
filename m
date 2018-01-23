From: aford173@gmail.com (Adam Ford)
Date: Tue, 23 Jan 2018 11:03:26 -0600
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v6_00=2F41=5D_ARM=3A_davinci=3A_convert_to_common?=
 =?UTF-8?Q?_clock_framework=E2=80=8B?=
In-Reply-To: <615bc302-e129-1501-63be-fa701f5ecaad@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <CAMRc=MexJTMiD=URw1bv-qfGaTntZRXgfsSb_beYGkvO+LrpgQ@mail.gmail.com>
 <d819e18f-7d74-d8c4-8056-bfc545f4d4e9@lechnology.com>
 <CAMRc=McVNJqsO4+j=XkyNWuKqF-S-hQAw9XxHx6GC47UudgMYw@mail.gmail.com>
 <e5f4af7d-971c-5694-2da5-0cba9083ee5c@lechnology.com>
 <615bc302-e129-1501-63be-fa701f5ecaad@lechnology.com>
Message-ID: <CAHCN7xLW=RjHHBjvDto=DRrNfNsQrsaGb0zmsRrwdc+7Wbhaxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 23, 2018 at 10:06 AM, David Lechner <david@lechnology.com> wrote:
> On 01/23/2018 10:03 AM, David Lechner wrote:
>>
>> You can see if the clock is enabled by running:
>>
>>      cat /sys/kernel/debug/clk/clk_summary
>>
>
> I just realized if you can't boot, you can't do this. :-/

I can boot with the latest set in your git repo, but the Ethernet
doesn't apparently fully operate.  I don't get errors, but I cannot
get a dhcp address.

I'll try to do a more exhaustive test later today to get an idea of
what works and what doesn't.  When I ran my basic tests, I just did a
feel-good boot test (and reboot test)

adam
