From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Tue, 13 May 2014 13:57:52 -0300
Subject: [PATCH 3/7] clk: sunxi: avoid double DT matching
In-Reply-To: <CAL_JsqL0wWi0Pz6NirzEVWeHKqrRiGB6Q+9JYp6ew5KTeeY0dQ@mail.gmail.com>
References: <1399940993-1773-1-git-send-email-robherring2@gmail.com>	<1399940993-1773-4-git-send-email-robherring2@gmail.com>
 <CAL_JsqL0wWi0Pz6NirzEVWeHKqrRiGB6Q+9JYp6ew5KTeeY0dQ@mail.gmail.com>
Message-ID: <53724F10.8030607@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

For 3/7 (with the mentioned fix) and 4/7 my Cubietruck still boots, so

Acked-by: Emilio L?pez <emilio@elopez.com.ar>
Tested-by: Emilio L?pez <emilio@elopez.com.ar>

El 13/05/14 12:12, Rob Herring escribi?:
> On Mon, May 12, 2014 at 7:29 PM, Rob Herring <robherring2@gmail.com> wrote:
>> From: Rob Herring <robh@kernel.org>
>>
>> Use for_each_matching_node_and_match instead of for_each_matching_node plus
>> of_match_node to avoid searching the DT twice for each node.
>>
>> The sunxi DT scanning code should really be re-worked rather than have
>> its own private matching infrastructure. It is working around needing a
>> function pointer and a data pointer for each compatible match.
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> Cc: "Emilio L?pez" <emilio@elopez.com.ar>
>> Cc: Mike Turquette <mturquette@linaro.org>
>> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>

Cheers,

Emilio
