From: robherring2@gmail.com (Rob Herring)
Date: Mon, 27 Jan 2014 12:14:49 -0600
Subject: [PATCH 0/2] Replace /include/ (dtc) with #include
In-Reply-To: <20140127163111.GA8358@arm.com>
References: <1389348970-5498-1-git-send-email-pankaj.dubey@samsung.com>
 <52E63DD8.9070909@samsung.com> <20140127163111.GA8358@arm.com>
Message-ID: <CAL_JsqLsSFW3JeYYMb2E3Wi68GM_r_BeJmhfom5BnX7EgaenrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 27, 2014 at 10:31 AM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Mon, Jan 27, 2014 at 11:07:04AM +0000, Pankaj Dubey wrote:
>> On 01/10/2014 07:16 PM, Pankaj Dubey wrote:
>> > Replace /include/ (dtc) with #include (C pre-processor) for all ARM64
>> > based SoC dts files.
>> >
>> > Pankaj Dubey (2):
>> >    arm64: dts: use #include for all AppliedMicro device tree files
>> >    arm64: dts: use #include for all ARM fast model device tree file
>> >
>> >   arch/arm64/boot/dts/apm-mustang.dts    |    2 +-
>> >   arch/arm64/boot/dts/rtsm_ve-aemv8a.dts |    2 +-
>> >   2 files changed, 2 insertions(+), 2 deletions(-)
>> >
>> Gentle ping.
>
> It would be good to include some rationale behind this change and I'm
> waiting for the DT guys to ack it.

Change this when you actually need it.

Rob
