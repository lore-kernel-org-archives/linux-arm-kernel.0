From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 21 Aug 2014 10:42:52 +0200
Subject: [PATCH 2/3] ARM: zynq: DT: Move size/address properties to dtsi
In-Reply-To: <53F4C615.9060908@suse.de>
References: <1408550219-19825-1-git-send-email-soren.brinkmann@xilinx.com>
 <1408550219-19825-2-git-send-email-soren.brinkmann@xilinx.com>
 <53F4C615.9060908@suse.de>
Message-ID: <19edc7a7-15e8-486f-87da-04c7625b661a@BL2FFO11FD024.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20/2014 06:00 PM, Andreas F?rber wrote:
> Am 20.08.2014 17:56, schrieb Soren Brinkmann:
>> Move the GEM's size and address cells properties to the common
>> dtsi file.
>>
>> Cc: Andreas F?rber <afaerber@suse.de>
>> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
>> ---
>>  arch/arm/boot/dts/zynq-7000.dtsi      | 4 ++++
>>  arch/arm/boot/dts/zynq-parallella.dts | 2 --
>>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Andreas F?rber <afaerber@suse.de>

Applied.

Thanks,
Michal


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140821/953eca55/attachment.sig>
