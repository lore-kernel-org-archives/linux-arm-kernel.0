From: carlo@caione.org (Carlo Caione)
Date: Mon, 7 Mar 2016 10:01:53 +0100
Subject: [PATCH 4/4] documentation: Fix pinctrl documentation for Meson8 /
 Meson8b
In-Reply-To: <20160305042646.GL13525@rob-hp-laptop>
References: <1456869876-19320-1-git-send-email-carlo@caione.org>
 <1456869876-19320-5-git-send-email-carlo@caione.org>
 <20160305042646.GL13525@rob-hp-laptop>
Message-ID: <CAOQ7t2bd5-xeUkwjN4cqi=xa602B8JwZ4vvrUF1VL4y2=pkV_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 5, 2016 at 5:26 AM, Rob Herring <robh@kernel.org> wrote:
> On Tue, Mar 01, 2016 at 11:04:36PM +0100, Carlo Caione wrote:
>> From: Carlo Caione <carlo@endlessm.com>
>>
>> Fix pin controller documentation with the new compatibles.
>
> What was wrong with it? (answer in the commit msg)

I'll extend the commit message.

[...]
>>  Required properties for the root node:
>> - - compatible: "amlogic,meson8-pinctrl" or "amlogic,meson8b-pinctrl"
>> + - compatible: "amlogic,meson8-cbus-pinctrl", "amlogic,meson8b-cbus-pinctrl",
>> +   "amlogic,meson8-aobus-pinctrl" or "amlogic,meson8b-aobus-pinctrl"
>
> Reformat with 1 per line (assuming each are mutually exclusive).

ok

[...]
>> -Valid sub-node names are:
>> - - "banks" for the regular domain
>> - - "ao-bank" for the always-on domain
>> -
>
> Why are these being removed?

Because we are not forced anymore to use those specific names for the sub-nodes.

-- 
Carlo Caione
