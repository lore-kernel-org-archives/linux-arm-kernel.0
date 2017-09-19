From: jeffy.chen@rock-chips.com (jeffy)
Date: Tue, 19 Sep 2017 21:04:26 +0800
Subject: [PATCH v12 2/2] ASoC: rockchip: Use bus_type to distinguish rt5514
 dsp from rt5514 codec
In-Reply-To: <20170919124613.egvojfhq74vhyvuh@sirena.co.uk>
References: <20170919025439.7107-1-jeffy.chen@rock-chips.com>
 <20170919025439.7107-2-jeffy.chen@rock-chips.com>
 <20170919124613.egvojfhq74vhyvuh@sirena.co.uk>
Message-ID: <59C115DA.4000907@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 09/19/2017 08:46 PM, Mark Brown wrote:
> On Tue, Sep 19, 2017 at 10:54:39AM +0800, Jeffy Chen wrote:
>> Currently rt5514 dsp and rt5514 codec are sharing the same compatible.
>> Use bus_type to distinguish rt5514 dsp from rt5514 codec.
>
> This doens't apply against current code, please check and resend.
>

i sent a new series which contains all my patches and base on 
840cc455c5f5 Add linux-next specific files for 20170919

please help to check, thanks :)

https://py3.patchwork.dja.id.au/patch/66384/
...
https://py3.patchwork.dja.id.au/patch/66389/
