From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 28 Jan 2015 15:21:19 +0100
Subject: [PATCH 1/2] ARM: zynq: Remove bogus value from 'bias-disable'
 property
In-Reply-To: <54C6DDE8.3000905@suse.de>
References: <1422301796-22888-1-git-send-email-soren.brinkmann@xilinx.com>
 <54C6DDE8.3000905@suse.de>
Message-ID: <ce6e56872ab744a49612ef9bca07c73d@BN1AFFO11FD005.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/27/2015 01:38 AM, Andreas F?rber wrote:
> Am 26.01.2015 um 20:49 schrieb Soren Brinkmann:
>> In one pinctrl node, a 'bias-disable' property is erroneously assigned a
>> value.
>>
>> Fixes: ARM: zynq: DT: Add pinctrl information
>> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> 
> Reviewed-by: Andreas F?rber <afaerber@suse.de>
> 
> Andreas
> 

Applied both.

Thanks,
Michal

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150128/855ae9ea/attachment.sig>
