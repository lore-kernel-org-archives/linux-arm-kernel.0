From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 22 Jan 2014 10:41:55 +0200
Subject: [PATCHv3 00/41] OMAPDSS: DT support v3
In-Reply-To: <52DEE6B0.20106@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
 <52DEE6B0.20106@ti.com>
Message-ID: <52DF8453.7030501@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-01-21 23:29, Nishanth Menon wrote:
> Tomi,
> 
> On 01/21/2014 04:56 AM, Tomi Valkeinen wrote:
>> Hi,
>>
>> Here's version 3 of the DSS DT series.
>>
>> The previous version can be found from:
>>
>> v1: http://permalink.gmane.org/gmane.linux.ports.arm.omap/108249
>> v2: http://permalink.gmane.org/gmane.linux.ports.arm.omap/108866
>>
>> The main changes to v2 are:
>>
>> - DT Binding documentation
>> - OMAP2 DSS support
>> - Split DSI register space
>> - DSS nodes disabled by default
>> - Hack to have generic DT bindings but OMAP specific drivers (for now)
>>
>> This series can also be found from:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git work/dss-dt-review-3
>>
> http://slexy.org/view/s20JhteOFR is my quick build test report -> few
> checkpatch and build bisect issues would probably need fixing.

Thanks. Shouldn't make trivial changes, and then not run a full
commit-by-commit compile test...

I fixed the issues and pushed the branch again to work/dss-dt-review-3.
The fixes are minor, so the already posted series can be reviewed.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140122/257a5b6c/attachment.sig>
