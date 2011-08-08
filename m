From: olof@lixom.net (Olof Johansson)
Date: Mon, 8 Aug 2011 07:51:14 -0700
Subject: [PATCH 2/2] arm/tegra: Delete irq_to_gpio
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF049F172168@HQMAIL01.nvidia.com>
References: <1312582534-10871-1-git-send-email-swarren@nvidia.com>
	<1312582534-10871-2-git-send-email-swarren@nvidia.com>
	<20110806174519.GB31966@ponder.secretlab.ca>
	<74CDBE0F657A3D45AFBB94109FB122FF049F172168@HQMAIL01.nvidia.com>
Message-ID: <CAOesGMi2CXyAoy56-SdaD5YFzXW6W4wP6mnH+bVvRR3i_Mhk2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 8, 2011 at 7:26 AM, Stephen Warren <swarren@nvidia.com> wrote:
> Grant Likely wrote at Saturday, August 06, 2011 11:45 AM:
>> On Fri, Aug 05, 2011 at 04:15:34PM -0600, Stephen Warren wrote:
>> > irq_to_gpio is deprecated and in the process of being removed. Make that
>> > happen now for ARM Tegra.
>> >
>> > Signed-off-by: Stephen Warren <swarren@nvidia.com>
>>
>> Applied both. ?Thanks.
>
> Didn't you want an Ack by a Tegra maintainer first?

Acked-by: Olof Johansson <olof@lixom.net>

But either way is OK. No need to rebase to add an acked-by, as far as
I am concerned.


-Olof
