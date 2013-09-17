From: csd@broadcom.com (Christian Daudt)
Date: Tue, 17 Sep 2013 15:04:54 -0700
Subject: [PATCH] ARM: bcm: Add DEBUG_LL console support
In-Reply-To: <20130917220323.GS12758@n2100.arm.linux.org.uk>
References: <1379455187-5812-1-git-send-email-csd@broadcom.com>
 <20130917220323.GS12758@n2100.arm.linux.org.uk>
Message-ID: <5238D206.9030701@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-09-17 03:03 PM, Russell King - ARM Linux wrote:
> On Tue, Sep 17, 2013 at 02:59:47PM -0700, Christian Daudt wrote:
>> This patch adds low level debug uart support to Broadcom
>>   mobile based SOCs.
>>
>> Signed-off-by: Christian Daudt <csd@broadcom.com>
>> Reviewed-by: James King <jamesk@broadcom.com>
> Unfortunately, your patch is out of date.
>
> Please have a look at v3.12-rc1's debugging infrastructure.  You should
> not need to add any .S file(s) for 8250 based ports, and in fact,
> 8250_32.S is gone.  It's now all done through Kconfig for these ports.
>
> Thanks.
>
Oops. Ok, I last rebased it against -11-rc4. I'll rework it for 12-rc1 then.

  Thanks,
    csd
