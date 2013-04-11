From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 11 Apr 2013 22:48:27 +0200
Subject: [PATCH v3 5/9] ARM: dts: Add a 64 bits version of the skeleton
 device tree
In-Reply-To: <20130411181200.GP28693@titan.lakedaemon.net>
References: <1365461538-30702-1-git-send-email-gregory.clement@free-electrons.com>
 <1365461538-30702-6-git-send-email-gregory.clement@free-electrons.com>
 <20130411181200.GP28693@titan.lakedaemon.net>
Message-ID: <5167219B.8070404@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On 04/11/2013 08:12 PM, Jason Cooper wrote:
> On Tue, Apr 09, 2013 at 12:52:13AM +0200, Gregory CLEMENT wrote:
>> From: Lior Amsalem <alior@marvell.com>
>>
>> In order to be able to use more than 4GB address-cells and size-cells
>> have to be set to 2
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> Signed-off-by: Lior Amsalem <alior@marvell.com>
>> ---
>>  arch/arm/boot/dts/skeleton64.dtsi |   13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/skeleton64.dtsi
> 
> Applied to mvebu/dt
> 
> Gregory,
> 
> Once I can pull in Thomas' pci work, you'll just need to rebase patches
> 1, and 6 - 9 against mvebu/dt.
> 

Yes sure! When did you plan to pull the dts part of Thomas' pci work?
Is there still anything left to prevent to pull this part?

Thanks,
-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
