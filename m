From: carlo@caione.org (Carlo Caione)
Date: Wed, 11 May 2016 11:18:11 +0200
Subject: [PATCH 0/7] pinctrl: meson: Add a bunch more pins
In-Reply-To: <CACRpkdY99HWOQ4fhuYuPZ4JpwK6s75TXYpaBaBxhLLJFRLCd6w@mail.gmail.com>
References: <1462544486-9516-1-git-send-email-khilman@baylibre.com>
 <CACRpkdY99HWOQ4fhuYuPZ4JpwK6s75TXYpaBaBxhLLJFRLCd6w@mail.gmail.com>
Message-ID: <CAOQ7t2Ys-zow-wn4p5chYxrYrjun-9_5p4_Xij6bXLApyt5itw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2016 at 10:57 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Fri, May 6, 2016 at 4:21 PM, Kevin Hilman <khilman@baylibre.com> wrote:
>
>> Add support for several more devices, both in the EE domain and in the
>> AO domain.  Also, add the pins to the corresponding DTS files.
>>
>> Tested on odroid-c2 and Amlogic P200 boards, and verified with working
>> ethernet.
>>
>> Depends on the initial GXBB pinctrl support from Carlo[1].  Also
>> available in my git tree[2] with all the dependencies included.
>
> Carlo can you review Kevin's patches? I'd like to apply them if
> nothing's controversial about them.

Go ahead and apply them:

Acked-by: Carlo Caione <carlo@endlessm.com>

The ack is on the formal correctness since I still do not have access
to the datasheet.

Thanks,

-- 
Carlo Caione
