From: nm@ti.com (Nishanth Menon)
Date: Thu, 28 Aug 2014 07:01:38 -0500
Subject: [PATCH v2 1/2] ARM: DRA7: Add support for soc_is_dra74x() and
 soc_is_dra72x() variants
In-Reply-To: <alpine.DEB.2.02.1408280618480.21985@utopia.booyaka.com>
References: <1406523237-6905-1-git-send-email-lokeshvutla@ti.com>
 <1406523237-6905-2-git-send-email-lokeshvutla@ti.com>
 <alpine.DEB.2.02.1407280529320.24161@utopia.booyaka.com>
 <53D5E0F4.3080607@ti.com>
 <CAGo_u6pZiyJ8574YUXvg_Pz_P=LDeot-kFh7NQJBUqgwsR+Fmw@mail.gmail.com>
 <alpine.DEB.2.02.1408280618480.21985@utopia.booyaka.com>
Message-ID: <CAGo_u6qLJdrHw-FosDvhdvMQxQntf=ujZdRW+MrCdqbHZruU4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 28, 2014 at 1:19 AM, Paul Walmsley <paul@pwsan.com> wrote:
> On Wed, 27 Aug 2014, Nishanth Menon wrote:
>
>> On Mon, Jul 28, 2014 at 12:34 AM, Lokesh Vutla <lokeshvutla@ti.com> wrote:
>> > On Monday 28 July 2014 10:59 AM, Paul Walmsley wrote:
>> >> On Mon, 28 Jul 2014, Lokesh Vutla wrote:
>> >>
>> >>> From: Rajendra Nayak <rnayak@ti.com>
>> >>>
>> >>> Use the corresponding compatibles to identify the devices.
>> >>>
>> >>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> >>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> >>> Acked-by: Nishanth Menon <nm@ti.com>
>> >>> Tested-by: Nishanth Menon <nm@ti.com>
>> >>
>> >> Thanks, queued for (hopefully) early v3.17-rc.
>> > Thanks Paul.
>> >
>> Paul, Tony,
>>
>> we are at 3.17-rc2 today, unfortunately..
>> http://slexy.org/view/s20MbRgipa dra72-evm is still broken due to
>> this. Needs:
>> https://patchwork.kernel.org/patch/4632161/ and
>> https://patchwork.kernel.org/patch/4632171/
>>
>> What can we do to help speed this along?
>
> A simple reminder, like this one, is good.  Also providing boards and
> documentation generally helps, so the patches can be tested and reviewed.

TI is working diligently towards a public TRM and potentially a
related platform as well for all.

Unfortunately, I am not yet aware of a official finalized release
date.. hopefully this year..

In the meanwhile, we will try to provide test logs that you may desire
for at least the
platforms we have functioning and access to. please feel free to
request specific test
vectors if you feel our coverage is not good enough.

-- 
---
Regards,
Nishanth Menon
