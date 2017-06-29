From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 29 Jun 2017 21:18:12 +0900
Subject: [PATCH 3/5] dt-bindings: arm: Document Socionext MB86S71 and
 Fujitsu F-Cue
In-Reply-To: <20170628164605.2gnvrv4g7jluzyrm@rob-hp-laptop>
References: <20170625170020.11791-1-afaerber@suse.de>
 <20170625170020.11791-4-afaerber@suse.de>
 <20170628164605.2gnvrv4g7jluzyrm@rob-hp-laptop>
Message-ID: <CAK7LNATqjOMUajUCYVq=L6wWVTUEc1M7Po+KQ3M3Z=A7+FHX5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-06-29 1:46 GMT+09:00 Rob Herring <robh@kernel.org>:
> On Sun, Jun 25, 2017 at 07:00:18PM +0200, Andreas F?rber wrote:
>> For consistency with existing SoC bindings, use "fujitsu,mb86s71" but
>> socionext.txt.
>>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
>>  Documentation/devicetree/bindings/arm/socionext.txt | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/socionext.txt
>
> Acked-by: Rob Herring <robh@kernel.org>
> --

I do not mind this, but
please note there are multiple product lines in Socionext
because Socionext merged LSI divisions from Panasonic and Fujitsu.

I maintain documents for Socionext UniPhier SoC family
(which inherits SoC architecture of Panasonic)
in Documentation/devicetree/bindings/arm/uniphier/.





-- 
Best Regards
Masahiro Yamada
