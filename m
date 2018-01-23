From: david@lechnology.com (David Lechner)
Date: Tue, 23 Jan 2018 10:06:27 -0600
Subject: =?UTF-8?Q?Re:_[PATCH_v6_00/41]_ARM:_davinci:_convert_to_common_cloc?=
 =?UTF-8?Q?k_framework=e2=80=8b?=
In-Reply-To: <e5f4af7d-971c-5694-2da5-0cba9083ee5c@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <CAMRc=MexJTMiD=URw1bv-qfGaTntZRXgfsSb_beYGkvO+LrpgQ@mail.gmail.com>
 <d819e18f-7d74-d8c4-8056-bfc545f4d4e9@lechnology.com>
 <CAMRc=McVNJqsO4+j=XkyNWuKqF-S-hQAw9XxHx6GC47UudgMYw@mail.gmail.com>
 <e5f4af7d-971c-5694-2da5-0cba9083ee5c@lechnology.com>
Message-ID: <615bc302-e129-1501-63be-fa701f5ecaad@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/23/2018 10:03 AM, David Lechner wrote:
> You can see if the clock is enabled by running:
> 
>  ??? cat /sys/kernel/debug/clk/clk_summary
> 

I just realized if you can't boot, you can't do this. :-/
