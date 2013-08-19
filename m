From: csd@broadcom.com (Christian Daudt)
Date: Mon, 19 Aug 2013 15:10:50 -0700
Subject: [PATCH v3] ARM: DT: binding fixup to align with
 vendor-prefixes.txt
In-Reply-To: <520902E5.8030009@wwwdotorg.org>
References: <1376165636-14654-1-git-send-email-csd@broadcom.com>
 <520902E5.8030009@wwwdotorg.org>
Message-ID: <521297EA.9080300@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-08-12 08:44 AM, Stephen Warren wrote:
> On 08/10/2013 02:13 PM, Christian Daudt wrote:
>> [ this is a follow-up to this discussion:
>> http://archive.arm.linux.org.uk/lurker/message/20130730.230827.a1ceb12a.en.html ]
>> This patchset renames all uses of "bcm," name bindings to
>> "brcm," as they were done prior to knowing that brcm had
>> already been standardized as Broadcom vendor prefix
>> (in Documentation/devicetree/bindings/vendor-prefixes.txt).
>> This will not cause any churn on devices because none of
>> these bindings have made it into production yet.
>> Also rename the the following dt binding docs that had "bcm,"
>> in their name for consistency:
>>   - bcm,kona-sdhci.txt -> kona-sdhci.txt
>>   - bcm,kona-timer.txt -> kona-timer.txt
> Acked-by: Stephen Warren <swarren@nvidia.com>
>
I've submitted the cache-l2x0.c portion to patches at arm.linux.org.ok and 
pulled the rest into my bcm/for-3.12/dt tree.
  thanks,
    csd
