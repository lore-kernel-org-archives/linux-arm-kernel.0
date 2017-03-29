From: steve_longerbeam@mentor.com (Steve Longerbeam)
Date: Tue, 28 Mar 2017 17:35:52 -0700
Subject: [PATCH v6 02/39] [media] dt-bindings: Add bindings for i.MX media
 driver
In-Reply-To: <CAL_JsqJm_JjuVPcOBERCqsnjTDdNoKr9xRE9MXMO4ivxGath2Q@mail.gmail.com>
References: <1490661656-10318-1-git-send-email-steve_longerbeam@mentor.com>
 <1490661656-10318-3-git-send-email-steve_longerbeam@mentor.com>
 <CAL_JsqJm_JjuVPcOBERCqsnjTDdNoKr9xRE9MXMO4ivxGath2Q@mail.gmail.com>
Message-ID: <70bacfb5-aef1-76d1-37d2-23a524903d45@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/28/2017 05:21 PM, Rob Herring wrote:
> On Mon, Mar 27, 2017 at 7:40 PM, Steve Longerbeam <slongerbeam@gmail.com> wrote:
>> Add bindings documentation for the i.MX media driver.
>>
>> <snip>
>> +
>> +mipi_csi2 node
>> +--------------
>> +
>> +This is the device node for the MIPI CSI-2 Receiver, required for MIPI
>> +CSI-2 sensors.
>> +
>> +Required properties:
>> +- compatible   : "fsl,imx6-mipi-csi2", "snps,dw-mipi-csi2";
>
> As I mentioned in v5, there's a DW CSI2 binding in progress. This
> needs to be based on that.

Hi Rob, I'm not sure what you are asking me to do.

I assume if there's another binding doc in progress, it means
someone is working on another Synopsys DW CSI-2 subdevice driver.

Unfortunately I don't have the time to contribute and switch to
this other subdevice, and do test/debug.

For now I would prefer if this patchset is merged as is, and
then contribute/switch to another CSI-2 subdev later. It is
also getting very difficult managing all these patches (39 as
of this version), and I'd prefer not to spam the lists with
such large patchsets for too much longer.


Steve
