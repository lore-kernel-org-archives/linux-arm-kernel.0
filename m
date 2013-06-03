From: monstr@monstr.eu (Michal Simek)
Date: Mon, 03 Jun 2013 09:49:18 +0200
Subject: [GIT PULL] arm-soc: Xilinx zynq clock changes for v3.11
In-Reply-To: <20130601234708.21525.1684@quantum>
References: <51A31045.1060406@monstr.eu>
 <20130601051913.GC5189@quad.lixom.net> <20130601234708.21525.1684@quantum>
Message-ID: <51AC4A7E.1070509@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/2013 01:47 AM, Mike Turquette wrote:
> Quoting Olof Johansson (2013-05-31 22:19:13)
>> On Mon, May 27, 2013 at 09:50:29AM +0200, Michal Simek wrote:
>>> Hi Arnd and Olof,
>>>
>>> please pull the following changes to your arm-soc tree.
>>> We haven't got any response from audience or clk maintainer
>>> but we discussed these changes with him in several threads.
>>> The major change is to have easy to going DT clock description
>>> in one node and do not describe the whole clock tree in details
>>> which none uses.
>>
>> Hi,
>>
>> I don't see any acks from Mike Turquette on any of these. Mike?
>>
> 
> I Acked it but they were never applied since my Ack came after the pull
> request had been sent:
> 
> http://article.gmane.org/gmane.linux.kernel/1499697

Yep. I can look how time went but I wait at least week for any reaction.
Mike was probably out that's why I have added patches to the branch
and sent pull request and then Mike sent his ACK.
If you like I can add Mike's ack to that patches and send you new pull
request.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130603/fcc4a712/attachment-0001.sig>
