From: eric@anholt.net (Eric Anholt)
Date: Mon, 27 Mar 2017 10:14:35 -0700
Subject: [GIT PULL 2/7] Broadcom devicetree changes for 4.12
In-Reply-To: <20170325213315.7dw2nugvhumhypbn@tarshish>
References: <20170324175807.27272-1-f.fainelli@gmail.com>
 <20170324175807.27272-2-f.fainelli@gmail.com>
 <20170325213315.7dw2nugvhumhypbn@tarshish>
Message-ID: <87d1d2wsjo.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Baruch Siach <baruch@tkos.co.il> writes:

> Hi Florian,
>
> On Fri, Mar 24, 2017 at 10:58:02AM -0700, Florian Fainelli wrote:
>> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
>> 
>>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
>> 
>> are available in the git repository at:
>> 
>>   http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.12/devicetree
>> 
>> for you to fetch changes up to 414ce21ae20547e0eea72fe0c4e8ee3280d30888:
>> 
>>   Merge tag 'bcm2835-dt-next-2017-03-21' into devicetree/next (2017-03-24 10:12:31 -0700)
>> 
>> ----------------------------------------------------------------
>> This pull request contains Broadcom ARM-based SoCs Device Tree updates for
>> 4.12, please pull the following:
>
> What about my dts fixes that were in the delayed 4.11 pull request[1]?
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/491554.html

I'm verry sorry to have misplaced those.  I've put them back on dt-next,
pushed, and will get a PR out after kbuild comes back clean.

(I thought that the 4.11 PR had got backed off to before the clk merge,
not discarded)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170327/282c168c/attachment.sig>
