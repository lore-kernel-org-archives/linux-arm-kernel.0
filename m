From: monstr@monstr.eu (Michal Simek)
Date: Wed, 01 May 2013 08:50:09 +0200
Subject: [PATCH 1/7] tty: xuartps: Sort #includes alphabetically
In-Reply-To: <20130501002321.GB7435@kroah.com>
References: <1367366284-28304-1-git-send-email-soren.brinkmann@xilinx.com>
 <1367366284-28304-2-git-send-email-soren.brinkmann@xilinx.com>
 <20130501000048.GA1840@kroah.com>
 <cbd8c55c-066b-4396-9a4b-97d58a93b573@DB8EHSMHS005.ehs.local>
 <20130501002321.GB7435@kroah.com>
Message-ID: <5180BB21.2080306@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/01/2013 02:23 AM, Greg Kroah-Hartman wrote:
> On Tue, Apr 30, 2013 at 05:05:40PM -0700, S?ren Brinkmann wrote:
>> On Tue, Apr 30, 2013 at 05:00:48PM -0700, Greg Kroah-Hartman wrote:
>>> On Tue, Apr 30, 2013 at 04:57:58PM -0700, Soren Brinkmann wrote:
>>>> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
>>>> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> CC: Jiri Slaby <jslaby@suse.cz>
>>>> CC: linux-serial at vger.kernel.org
>>>
>>> Why would you need/want to do this?
>> I often come across duplicated includes. Having some kind of order helps
>> avoiding that, imho.
> 
> We have a tool to handle duplicated includes, no need to put them in
> sorted order for them to be detected.

What's the name of tool which does that?
I have seen results from it but have never tried to find it out name and
how to use it.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130501/58277851/attachment.sig>
