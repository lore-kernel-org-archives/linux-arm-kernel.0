From: d.lavnikevich@sam-solutions.net (Dmitry Lavnikevich)
Date: Mon, 15 Sep 2014 15:07:02 +0300
Subject: [alsa-devel] [PATCH v2 2/4] ARM: dts: pbab01: enable I2S audio
 on phyFLEX-i.MX6 boards
In-Reply-To: <CAOMZO5C9_XwgcLvVWvxB1A306_Ehm17ZE111j6d+7MhudAhT0g@mail.gmail.com>
References: <1410356809-26179-1-git-send-email-d.lavnikevich@sam-solutions.com>	<1410537872-17274-1-git-send-email-d.lavnikevich@sam-solutions.com>	<1410537872-17274-3-git-send-email-d.lavnikevich@sam-solutions.com>	<1410539161.314611261@f174.i.mail.ru>
 <CAOMZO5C9_XwgcLvVWvxB1A306_Ehm17ZE111j6d+7MhudAhT0g@mail.gmail.com>
Message-ID: <5416D666.2050302@sam-solutions.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/14 19:40, Fabio Estevam wrote:
> On Fri, Sep 12, 2014 at 1:26 PM, Alexander Shiyan <shc_work@mail.ru> wrote:
>> Fri, 12 Sep 2014 19:04:30 +0300 ?? Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>:
>>> Audio on phyFLEX boards is presented by tlv320aic3007 codec connected
>>> over SSI interface.
>>>
>>> Signed-off-by: Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>
>>> ---
>> ...
>>> +&ssi2 {
>>> +     fsl,mode = "i2s-slave";
>>> +     status = "okay";
>>> +     #sound-dai-cells = <0>;
>>> +};
>> I have already sent patch to add "#sound-dai-cells" into all i.MX DT-files.
>> Shawn, can you point us to this tree/commit?
> https://git.kernel.org/cgit/linux/kernel/git/shawnguo/linux.git/commit/?h=for-next&id=36c7e8826cf32dd4dd34c71b526653b800414355
So should I base my next patchset on for-next branch of
git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
?
