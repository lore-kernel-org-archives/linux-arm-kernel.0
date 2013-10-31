From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Thu, 31 Oct 2013 09:15:12 -0300
Subject: [PATCH] clk: composite: .determine_rate support
In-Reply-To: <524CB920.2030901@elopez.com.ar>
References: <1379205479-26001-1-git-send-email-emilio@elopez.com.ar>
 <524CB920.2030901@elopez.com.ar>
Message-ID: <527249D0.6040900@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El 02/10/13 21:24, Emilio L?pez escribi?:
> Hi Mike,
>
> El 14/09/13 21:37, Emilio L?pez escribi?:
>> This commit adds .determine_rate support to the composite clock. It will
>> use the .determine_rate callback from the rate component if available,
>> and fall back on the mux component otherwise. This allows composite
>> clocks to enjoy the benefits of automatic clock reparenting.
>>
>> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
>> ---
>>
>> Hi Mike,
>>
>> This is a prerequisite patch for the sunxi driver changes that I'll send
>> shortly; I believe you already looked at this diff on IRC and agreed it
>> was sensible, so I hope it can be merged early for the 3.13 cycle
>> (unless someone else has any objections to the patch, that is).
>
> A couple of weeks have passed now; can you please review and apply this
> to your tree for 3.13 if you are ok with it?

Mike?
