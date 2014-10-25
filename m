From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 25 Oct 2014 10:10:15 -0200
Subject: [PATCH 1/2] ARM: dts: imx53: Improve SSI clocks description
In-Reply-To: <20140925075433.GE6405@dragon>
References: <1411082629-25860-1-git-send-email-festevam@gmail.com>
 <20140925075433.GE6405@dragon>
Message-ID: <CAOMZO5DYrH5-+QmNuppSEmmrqntusOM4ziXzTvRKtD4tqy0E7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn,

On Thu, Sep 25, 2014 at 4:54 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> On Thu, Sep 18, 2014 at 08:23:48PM -0300, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> SSI block has 'ipg' clock for internal peripheral access and also 'baud' clock
>> for generating bit clock when SSI operates in master mode.
>>
>> Add the extra 'baud' clock so that we can have SSI functional in master mode.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>
> Applied both, thanks.

I am not able to see these patches in linux-next yet.
