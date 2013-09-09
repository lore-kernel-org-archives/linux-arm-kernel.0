From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 9 Sep 2013 18:24:16 -0300
Subject: [PATCH 1/2] ARM: dts: mx6: Add mx6solo support
In-Reply-To: <CAOCHtYhJjxBL1AY0dxc+FofXqRT25g8yaO+Z6d09mfkJWT+i+A@mail.gmail.com>
References: <1378688408-8689-1-git-send-email-festevam@gmail.com>
 <20130909150823.GB5815@S2101-09.ap.freescale.net>
 <CAOMZO5Ab9qVsQica-x3091YPhttqpbr_NL=A2ddzL5znuDtAUw@mail.gmail.com>
 <CAOCHtYhJjxBL1AY0dxc+FofXqRT25g8yaO+Z6d09mfkJWT+i+A@mail.gmail.com>
Message-ID: <CAOMZO5D8VW=M_DW69p+p512Uw9eySt+PoM-iWN=m3jXb0tfvaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 9, 2013 at 1:19 PM, Robert Nelson <robertcnelson@gmail.com> wrote:

>> Ok, I made this test and it booted fine.
>>
>> So I will change U-boot so that it searches for imx6dl-wandboard.dtb
>> instead of imx6s-wandboard.dtb.
>
> Since there is no WiFi/Bluetooth on the "solo" vs the wandboard dual
> lite, we should really still have a separate solo dtb file..

I think we could still represent the im6solo-wandboard using the
imx6dl-wandboard.dts.

In the case of lack of bcm4329 populated on a mx6solo board, the SDHC3
port will just not probe bcm4329 without any negative effect, right?
