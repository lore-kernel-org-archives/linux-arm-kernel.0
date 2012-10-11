From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 11 Oct 2012 23:00:22 +0900
Subject: [PATCH 01/15] pinctrl: samsung: Detect and handle unsupported
 configuration types
In-Reply-To: <CACRpkdbRNfic7LYkcRWQSJjWop+OH7ap_z0UpPco6+m_AASYPA@mail.gmail.com>
References: <1349943081-27939-1-git-send-email-t.figa@samsung.com>
 <1349943081-27939-2-git-send-email-t.figa@samsung.com>
 <CACRpkdbRNfic7LYkcRWQSJjWop+OH7ap_z0UpPco6+m_AASYPA@mail.gmail.com>
Message-ID: <CAH9JG2UGFeF362amWEZAqah45K2_a-k4-n_uGs=t+3-DQf6xaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Thu, Oct 11, 2012 at 10:57 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Thu, Oct 11, 2012 at 10:11 AM, Tomasz Figa <t.figa@samsung.com> wrote:
>
>> This patch modifies the pinctrl-samsung driver to detect when width of a
>> bit field is set to zero (which means that such configuraton type is not
>> supported) and return an error instead of trying to modify an inexistent
>> register.
>>
>> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
>
> I'm quite happy with these 17 patches, but I'd like to have Thomas
> Abraham's definitive ACK before I merge anything.
Thomas did ACK at [00/17] ... mail.

Thank you,
Kyungmin Park
>
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
