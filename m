From: monstr@monstr.eu (Michal Simek)
Date: Mon, 23 Feb 2015 11:22:02 +0100
Subject: [PATCH] spi: xilinx: Use standard num-cs binding
In-Reply-To: <20150214053543.GL9110@finisterre.sirena.org.uk>
References: <67f3c196833c427a489ca2c530d08987a6b5ee2a.1421412912.git.michal.simek@xilinx.com>
 <CAHTX3dJRGhwo7FW+VJxfEJmx-9FdjFN5EnxG0RRDfMOm3=VU4A@mail.gmail.com>
 <20150214053543.GL9110@finisterre.sirena.org.uk>
Message-ID: <54EAFF4A.1080605@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 02/14/2015 06:35 AM, Mark Brown wrote:
> On Wed, Feb 11, 2015 at 12:07:20PM +0100, Michal Simek wrote:
>> 2015-01-16 13:55 GMT+01:00 Michal Simek <michal.simek@xilinx.com>:
> 
>>> Use standard num-cs binding property and setup
>>> "xlnx,num-ss-bits" as deprecated.
> 
>> Any update on this one?
> 
> Don't send content free quoted pings, they're just adding to the e-mail
> volume and hence wasting people's time.

How do you want me to send ping on pending patches?
Just send them with RESEND prefix?
I just want to clarify this.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150223/3ed33e2e/attachment.sig>
