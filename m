From: rob.herring@linaro.org (Rob Herring)
Date: Wed, 26 Feb 2014 15:56:02 -0600
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <6873065.LH15I057sX@wuerfel>
References: <20140226183454.GA14639@cbox> <5553754.0b4gMg5OS7@wuerfel>
 <20140226200537.GC16149@cbox> <6873065.LH15I057sX@wuerfel>
Message-ID: <CABGGisxHOVqLcG7hVAuAzdeic41KWSLLBSjQLSJQcjTXLhNCow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 2:22 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 26 February 2014 12:05:37 Christoffer Dall wrote:
>> On Wed, Feb 26, 2014 at 08:55:58PM +0100, Arnd Bergmann wrote:
>> > On Wednesday 26 February 2014 10:34:54 Christoffer Dall wrote:
>>
>> The most common response I've been getting so far is that people
>> generally want their VMs to look close to the real thing, but not sure
>> how valid an argument that is.
>>
>> Some people feel strongly about this and seem to think that ARMv8
>> kernels will only work with ACPI in the future...
>
> That is certainly a misconception that has caused a lot of trouble.
> We will certainly keep supporting FDT boot in ARMv8 indefinitely,
> and I expect that most systems will not use ACPI at all.

Furthermore, even enterprise distro kernels will boot DT based kernels
assuming the h/w support is mainlined despite statements to the
contrary. It is a requirement in mainline kernels that DT and ACPI
support to coexist. Distros are not going to go out of their way to
undo/break that. And since the boot interface is DT, you can't simply
turn off DT. :)

Rob
