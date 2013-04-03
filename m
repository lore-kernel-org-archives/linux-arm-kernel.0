From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 3 Apr 2013 14:18:14 +0200
Subject: [PATCH] pinctrl:sirf:re-arch and add support for new SiRFatlas6
 SoC
In-Reply-To: <CAGsJ_4wmn-LxxX-JeSJzdkVFSUeJ=vQrKHJr9yUtsoxG2BFHtw@mail.gmail.com>
References: <1363597988-7409-1-git-send-email-Barry.Song@csr.com>
 <CACRpkdYUTQ_7V1CbKbx05zgBONj6iUi=ekzSwmZz8dqeRx7ZJw@mail.gmail.com>
 <CAGsJ_4wmn-LxxX-JeSJzdkVFSUeJ=vQrKHJr9yUtsoxG2BFHtw@mail.gmail.com>
Message-ID: <CACRpkdaMYTXpnfg8MhRP5Fs_Qn2gwv=Xuk3YSYejxt+vK9D6+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 28, 2013 at 7:27 AM, Barry Song <21cnbao@gmail.com> wrote:
> 2013/3/28, Linus Walleij <linus.walleij@linaro.org>:

>>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>>
>> This is OK but can you please:
>
> ok. one issue is recently Arnd has given another changes in
> pinctrl-sirf in arm-soc multiple platform branch:
> https://git.kernel.org/cgit/linux/kernel/git/arm/arm-soc.git/commit/?h=prima2/multiplatform&id=67d71344fd09223820eb9de39b597ec29f035e89
>
> it makes us easily to get merging conflict. what is your suggestion
> about taking all these changes in 3.10?

Please send this to where the rest of the patches are with my ACK
(I guess the ARM SoC tree?)

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
