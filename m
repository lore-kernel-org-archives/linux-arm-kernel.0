From: robh@kernel.org (Rob Herring)
Date: Tue, 1 Dec 2015 07:58:58 -0600
Subject: [PATCH v2 02/10] drm/hisilicon: Add DT binding docs for hi6220
 display subsystem
In-Reply-To: <CAGd==07B4e6uevH5LmW_MeG4SbViKqQ+MwKTtWtXi4UBmv6pSw@mail.gmail.com>
References: <1448707145-69348-1-git-send-email-xinliang.liu@linaro.org>
 <1448707145-69348-3-git-send-email-xinliang.liu@linaro.org>
 <20151130193130.GA1616@rob-hp-laptop>
 <CAGd==07B4e6uevH5LmW_MeG4SbViKqQ+MwKTtWtXi4UBmv6pSw@mail.gmail.com>
Message-ID: <CAL_JsqLsdMb7MaDdfXGTx0-dV1y__RPhJVGSvAh=ftPpH9woKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 1, 2015 at 1:17 AM, Xinliang Liu <xinliang.liu@linaro.org> wrote:
> On 1 December 2015 at 03:31, Rob Herring <robh@kernel.org> wrote:
>
> Hi Rob, thank you for review.
>
>> On Sat, Nov 28, 2015 at 06:38:57PM +0800, Xinliang Liu wrote:
>>> Add the device tree binding documentation for hi6220 SoC display subsystem.
>>> drm master device binding doc.
>>> ADE display controller binding doc.
>>> DSI controller binding doc.

>>> +Required properties:
>>> +- compatible: Should be "hisilicon,<chip>-dss"
>>> +- #address-cells: should be set to 2.
>>> +- #size-cells: should be set to 2.
>>> +- range: to allow probing of subdevices.
>>> +
>>> +Optional properties:
>>> +- dma-coherent: Present if dma operations are coherent.
>>
>> Put this on the actually DMA master.
>
> The DMA modules reside in the begining of each channel(or plane) of ADE.
> So I need to put this dma-coherent property to ADE device node, right?

Right.

Rob
