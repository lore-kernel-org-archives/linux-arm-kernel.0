From: monstr@monstr.eu (Michal Simek)
Date: Tue, 13 Aug 2013 16:30:16 +0200
Subject: Zynq clk fixes
In-Reply-To: <20130726222501.7598.33060@quantum>
References: <51F26716.6030701@monstr.eu> <20130726200703.7598.86150@quantum>
 <a76b3a5d-dadc-43b3-87ee-3c65258c15d7@CO1EHSMHS029.ehs.local>
 <20130726222501.7598.33060@quantum>
Message-ID: <520A42F8.9050108@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On 07/27/2013 12:25 AM, Mike Turquette wrote:
> Quoting S?ren Brinkmann (2013-07-26 14:11:52)
>> On Fri, Jul 26, 2013 at 01:07:03PM -0700, Mike Turquette wrote:
>>> Quoting Michal Simek (2013-07-26 05:09:58)
>>>> Hi Mike, [cc: Arnd and Olof]
>>>>
>>>> Soren has found two bug fixes in zynq clk code.
>>>> Can you please add these two patches to your tree?
>>>> Will be great if you can add them to v3.11.
>>>>
>>>> Arnd, Olof: I expect that all these clock changes should go through Mike.
>>>> If I am wrong please let me know.
>>>
>>> Looks right to me. Do these fix regressions in the current -rc cycle?
>>
>> I doubt there are real regressions. But since it's still early in
>> the release cycle and the driver was added in this merge window, I'd prefer
>> having it hit a release kernel with these fixes included.
> 
> I've taken these into clk-fixes and added the following to the changelog
> for each patch:
> 
> "This does not fix a specific regression but the clock driver was merged
> for 3.11-rc1, so best to fix the known bugs before the release."

Can you please tell me where you have added these two patches?
      clk/zynq/clkc: Add dedicated spinlock for the SWDT
      clk/zynq/clkc: Add CLK_SET_RATE_PARENT flag to ethernet muxes

I can't see them in clk-fixes branch (this branch is pretty obsolete).
http://git.linaro.org/gitweb?p=people/mturquette/linux.git;a=summary

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
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130813/a5eb9a6a/attachment.sig>
