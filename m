From: codekipper@gmail.com (Code Kipper)
Date: Wed, 31 Jan 2018 10:54:29 +0100
Subject: [linux-sunxi][PATCH] ARM: dts: sunxi: h3/h5: Add DAI node for HDMI
In-Reply-To: <20180131071616.jrkd465cq4mgyyvm@flea.lan>
References: <20180129092223.12423-1-codekipper@gmail.com>
 <20180129102227.ejmbifzjqmba3yja@flea.lan>
 <27087126.4975652.1517222127863.JavaMail.zimbra@musers.siol.net>
 <20180131071616.jrkd465cq4mgyyvm@flea.lan>
Message-ID: <CAEKpxBmVzeUN=1F=APVomu4s4h2s83R4JX3EG1=1Mu_ZBSF96g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 January 2018 at 08:16, maxime ripard
<maxime.ripard@free-electrons.com> wrote:
> On Mon, Jan 29, 2018 at 11:35:27AM +0100, Jernej ?krabec wrote:
>> Hi Maxime,
>>
>> (previously I respond only to linux-sunxi mailing list)
>>
>> >On Mon, Jan 29, 2018 at 10:22:23AM +0100, codekipper at gmail.com wrote:
>> >> From: Marcus Cooper <codekipper@gmail.com>
>> >>
>> >> Add the new DAI block for I2S2 which is used for HDMI audio.
>> >>
>> >> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>> >
>> >queued for 4.17, thanks!
>> >Maxime
>>
>> Please note that HDMI I2S has usable 4 I2S lanes, since HDMI
>> supports 8 channel audio. As Marcus said, other blocks probably
>> support them too, they are just not wired out on pins.
>
> I've dropped those patches for now.
>
>> Should we change compatible for HDMI?
>
> I guess, another way of doing things if they are strictly identical
> but for the number of lanes they support would be to add a DT property
> for that number of lanes.
>
That's fine...I'll look into adding a dt property and how we would map
channels to lanes.
Do you know of any examples?,
BR,
CK
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
