From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 13 Aug 2013 13:28:49 +0200
Subject: [PATCH 7/9] ARM: dove: add PCIe controllers to SoC DT
In-Reply-To: <20130812200452.GW25111@titan.lakedaemon.net>
References: <1376333215-12885-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376333215-12885-8-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130812200452.GW25111@titan.lakedaemon.net>
Message-ID: <520A1871.4000501@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/13 22:04, Jason Cooper wrote:
> On Mon, Aug 12, 2013 at 08:46:53PM +0200, Sebastian Hesselbarth wrote:
>> This adds a node for the pcie controllers found on Dove SoCs to the
>> SoC DT include.
>>
>> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>> ---
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Jason Cooper <jason@lakedaemon.net>
>> Cc: Andrew Lunn <andrew@lunn.ch>
>> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> Cc: linux-kernel at vger.kernel.org
>> Cc: linux-arm-kernel at lists.infradead.org
>> ---
>>   arch/arm/boot/dts/dove.dtsi |   54 +++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 54 insertions(+)
>
> patches 7-9 applied to mvebu/dove_mbus since the dependencies are
> cleaner that way.

Jason,

I will have to slightly modify the reset-gpio property names and that
requires a fixup patch for patch 8. Can you still squash it or do you
need a proper patch?

Sebastian

---


-------------- next part --------------
A non-text attachment was scrubbed...
Name: d3plug-dts.diff
Type: text/x-patch
Size: 404 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130813/424c82b2/attachment.bin>
