From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Nov 2012 11:29:55 +0100
Subject: [PATCH 0/2] clk: ux500: Make mtu driver use apb_pclock
In-Reply-To: <20121112183615.17970.20162@nucleus>
References: <1351080821-18660-1-git-send-email-ulf.hansson@stericsson.com>
 <CACRpkdb3dcDhVD5qkOrRkLJ-RXdmqJ2tAkosoeEB_DwSDSShKw@mail.gmail.com>
 <20121110012449.16569.82732@nucleus>
 <CACRpkdbGnvywcQWRN9v_=1nkmaqgJK92Zs1S5HSLgppa49bQqw@mail.gmail.com>
 <20121112183615.17970.20162@nucleus>
Message-ID: <CACRpkdYmPvRLcEjSNwC51sZw+g3iH3a5r7+7USEWJONmR4q4JQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2012 at 7:36 PM, Mike Turquette <mturquette@ti.com> wrote:
> Quoting Linus Walleij (2012-11-11 10:47:46)

>> I don't know quite how ingenious git is in detecting
>> patches on moved files, but if it's causing trouble
>> I think it's better if you could ACK them and we
>> could reubmit them to ARM SoC on the multiplatform
>> branch. i.e. this one:
>> http://git.kernel.org/?p=linux/kernel/git/arm/arm-soc.git;a=shortlog;h=refs/heads/next/multiplatform
>>
>
> Those patches have my ACK.  Do you want to wait to see if something goes
> boom or would you rather I drop them from clk-next preemptively?

Hm that's basically a question of how smart git is when
merging these trees together.

Arnd, Olof: what is your experience? If one tree is moving
files and another tree is patching them, should we try to
rebase these onto your branch in ARM SoC and submit
them there instead?

Yours,
Linus Walleij
