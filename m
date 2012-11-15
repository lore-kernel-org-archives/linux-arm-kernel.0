From: b32955@freescale.com (Huang Shijie)
Date: Thu, 15 Nov 2012 17:11:42 +0800
Subject: [PATCH v2 2/3] serial: mxs-auart: add the DMA support for mx28
In-Reply-To: <50A4983F.8080407@bluegiga.com>
References: <1351074456-25863-1-git-send-email-b32955@freescale.com>
 <1351074456-25863-3-git-send-email-b32955@freescale.com>
 <50A21613.6030709@bluegiga.com> <50A45F83.1010009@freescale.com>
 <50A4983F.8080407@bluegiga.com>
Message-ID: <50A4B1CE.5070203@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?11?15? 15:22, Lauri Hintsala ??:
> Hi,
>
> On 11/15/2012 05:20 AM, Huang Shijie wrote:
>> ? 2012?11?13? 17:42, Lauri Hintsala ??:
>>> Hi Huang,
>>>
>>> DMA support doesn't work with latest stable v3.6.5 or development
>>> 3.7-rc5 kernels. I get following error message when I open the serial
>>> port /dev/ttyAPP0:
>>>
>>> [ 48.730000] mxs-auart 8006a000.serial: step 1 error
>>> [ 48.750000] mxs-auart 8006a000.serial: We can not start up the DMA.
>>>
>> I tested this patch set in imx28-evk board Rev C with 
>> linux-next-20121114.
>> it works fine.
>>
>> Maybe you can try the linux-next code.
>
> I tested linux-next-20121114 on apx4devkit (imx28 based device) and I 
> got the same error message:
>
> # stty -F /dev/ttyAPP0 crtscts; microcom /dev/ttyAPP0 -s 115200
> [  133.710000] mxs-auart 8006a000.serial: step 1 error
> [  133.720000] mxs-auart 8006a000.serial: We can not start up the DMA.
Could you test this patch?

thanks
Huang  Shijie
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-fix-patch.patch
Type: text/x-patch
Size: 2010 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121115/10ceb0c7/attachment.bin>
