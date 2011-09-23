From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Fri, 23 Sep 2011 09:11:19 -0400
Subject: Identifying Primecells
In-Reply-To: <4E7C7FA2.30404@gmail.com>
References: <CAKON4OxqqBh4xFLwiMZzsGrnoG8erQ0hMFX-_VA-EDMvdNkvQQ@mail.gmail.com>
	<4E7C7FA2.30404@gmail.com>
Message-ID: <CAKON4OzGEo+XvcNg=mzp3jhq3d3m7Z9bvZTSVCNLNjZ=KYbNBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2011 at 8:46 AM, Rob Herring <robherring2@gmail.com> wrote:
> On 09/22/2011 01:19 PM, jonsmirl at gmail.com wrote:
>> I'm working on device tree support for the NXP LPC3130. To do this
>> right I need to know what specific Primecells were used in the chip.
>> How do I identify the primecell numbers for the devices? It is a
>> 926ejs core.
>>
>
> I'm not sure I understand the question.
>
> The primecell periph id numbers are only in the DT if they are wrong in
> the h/w for some reason. The compatible property should contain the
> device model number (i.e. "arm,pl011" for the uart).

So how do I figure out which id numbers to use for the NXP LPC3130?
Is the UART a pl011?


>
> Rob
>



-- 
Jon Smirl
jonsmirl at gmail.com
