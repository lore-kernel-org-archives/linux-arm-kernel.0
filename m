From: peter.ujfalusi@ti.com (Ujfalusi, Peter)
Date: Wed, 15 Feb 2012 17:52:37 +0200
Subject: [RFC 04/11] ASoC: core - Add API call to register dai kcontrols.
In-Reply-To: <1329320781.14552.1.camel@odin>
References: <1329320280-1621-1-git-send-email-peter.ujfalusi@ti.com>
 <1329320280-1621-5-git-send-email-peter.ujfalusi@ti.com>
 <1329320781.14552.1.camel@odin>
Message-ID: <CAPo=G1zK9zB7ZEHa3_0ZfGsxFkqcvPcvQv4Nkjd3GFUwCYFTvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2012 at 5:46 PM, Liam Girdwood <lrg@ti.com> wrote:
> On Wed, 2012-02-15 at 17:37 +0200, Peter Ujfalusi wrote:
>> Allow dai drivers to register kcontrols.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>> ?include/sound/soc.h ?| ? ?2 ++
>> ?sound/soc/soc-core.c | ? 31 +++++++++++++++++++++++++++++++
>> ?2 files changed, 33 insertions(+), 0 deletions(-)
>
> This feature has already been applied.

Oh, I'll take a look and use the existing feature.

Thanks,
P?ter
