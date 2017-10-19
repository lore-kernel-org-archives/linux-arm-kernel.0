From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 19 Oct 2017 09:29:03 +0900
Subject: [PATCH net-next v2 2/2] net: ethernet: socionext: add AVE
 ethernet driver
In-Reply-To: <20171018192359.243C.4A936039@socionext.com>
References: <1507854928-4357-3-git-send-email-hayashi.kunihiko@socionext.com>
 <CAK7LNAR0Dy0aUjQKw7YxSbXZkpjn=1B7_knkSed6=EDVzL6v9w@mail.gmail.com>
 <20171018192359.243C.4A936039@socionext.com>
Message-ID: <CAK7LNARuoK-M9iKyP7JxRgH7naA+teikqZMOHm3f2wykEieqLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-10-18 19:23 GMT+09:00 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>:
> On Mon, 16 Oct 2017 00:08:21 +0900 <yamada.masahiro@socionext.com> wrote:

>> priv->rst = devm_reset_control_get_optional_shared(dev, NULL);
>> if (IS_ERR(priv->rst))
>>           return PTR_ERR(priv->rst);
>
> The clk and reset are optional in the driver.
> Referring to your suggested method, I'll fix the part of clk and reset.
>


Why is clk optional?





-- 
Best Regards
Masahiro Yamada
