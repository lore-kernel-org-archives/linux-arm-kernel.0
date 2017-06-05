From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 5 Jun 2017 16:17:06 +0800
Subject: [PATCH 0/2] ARM/arm64: sunxi: convert CCU raw numbers to macros
In-Reply-To: <20170605081423.sx7qqjq73646enlm@flea.lan>
References: <20170605043224.20687-1-wens@csie.org>
 <20170605081423.sx7qqjq73646enlm@flea.lan>
Message-ID: <CAGb2v66eV4cX-w1ZBNRGrkJ8HNv0HY0ei2bZ7T+=zwTHhVkRew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 5, 2017 at 4:14 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Mon, Jun 05, 2017 at 12:32:22PM +0800, Chen-Yu Tsai wrote:
>> Hi Maxime,
>>
>> These are some clean up patches for 4.12. They convert raw number
>> references for the CCU and R_CCU nodes, from when the CCU/R_CCU stuff
>> was first added, to the defined macros in the device tree header files.
>>
>> These affect the A64 and H3/H5.
>>
>> These are based on our sunxi/fixes-for-4.12 branch. Once these are merged,
>> I think it's time to send off pull requests for our fixes branches.
>>
>> ChenYu
>
> Applied both, thanks!
> Maxime

Argh... Could you fix the build break on patch 1? It's simply

    sed -i -e 's/RST_IR/RST_APB0_IR/' arch/arm/boot/dts/sunxi-h3-h5.dtsi

Thanks
ChenYu
