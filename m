From: eric@anholt.net (Eric Anholt)
Date: Mon, 24 Apr 2017 17:02:07 -0700
Subject: [PATCH 2/2] ARM: dts: Add the ethernet and ethernet PHY to the
 cygnus core DT.
In-Reply-To: <1759fb29-0678-0ec5-5398-16c4a3ba9660@gmail.com>
References: <20170424215022.30382-1-eric@anholt.net>
 <20170424215022.30382-3-eric@anholt.net>
 <1759fb29-0678-0ec5-5398-16c4a3ba9660@gmail.com>
Message-ID: <87zif5cq2o.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Florian Fainelli <f.fainelli@gmail.com> writes:

> On 04/24/2017 02:50 PM, Eric Anholt wrote:
>> Cygnus has a single amac controller connected to the B53 switch with 2
>> PHYs.  On the BCM911360_EP platform, those two PHYs are connected to
>> the external ethernet jacks.
>> 
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>
> This looks fine, just a few nits on the label names:

Thanks.  I've applied all of these (and Andrew's and Scott's
suggestions), and I'll send out a new version once the DT maintainers
have had a chance to look.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170424/897c79ae/attachment.sig>
