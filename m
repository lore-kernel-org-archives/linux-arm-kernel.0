From: csd@broadcom.com (Christian Daudt)
Date: Tue, 6 Aug 2013 14:40:20 -0700
Subject: [PATCH v2] ARM: DT: binding fixup to align with
 vendor-prefixes.txt
In-Reply-To: <520079DB.5090309@wwwdotorg.org>
References: <1375482479-15732-1-git-send-email-csd@broadcom.com>
 <51FFCC42.6040300@wwwdotorg.org> <5200407A.4010407@broadcom.com>
 <520079DB.5090309@wwwdotorg.org>
Message-ID: <52016D44.7060808@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-08-05 09:21 PM, Stephen Warren wrote:
>>>>    Required root node property:
>>>>    -compatible = "bcm,bcm11351";
>>>> +compatible = "brcm,bcm11351";
>>> In a patch of mine that deprecated a property, Mark wondered if it would
>>> make sense to mention the old deprecated DT content simply to document
>>> that it existed, so that old DTs would still make sense when checking
>>> the documentation. I wonder if the same argument applies to this patch?
>> I would think the opposite. Deprecated items should be dropped from
>> documentation. They are in the code (for a holdover period) but clearly
>> marked as deprecated. No one should be extending the life of these, and
>> adding documentation on it is a step in the wrong direction of making it
>> easier for it to linger beyond what it should.
> The deprecated stuff will have to be fully documented once the DT schema
> validation is in place...
>
This deprecated code should be short lived, given that in actual fact it 
is actually quite unnecessary since no boards exist that rely on it.

  thanks,
    csd
