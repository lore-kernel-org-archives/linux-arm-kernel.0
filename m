From: jcm@redhat.com (Jon Masters)
Date: Wed, 07 Jan 2015 15:05:14 -0500
Subject: [Linaro-acpi] [PATCH v5 18/18] Documentation: ACPI for ARM64
In-Reply-To: <54AD8FF2.60407@redhat.com>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <2161376.07iV9ANMSk@wuerfel>
 <20150107115039.GA2199@e104818-lin.cambridge.arm.com>
 <1520439.Y1rXzXY1eS@wuerfel> <20150107172741.GY2634@sirena.org.uk>
 <20150107184158.GO24989@titan.lakedaemon.net> <54AD8FF2.60407@redhat.com>
Message-ID: <54AD917A.2040307@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/07/2015 02:58 PM, Jon Masters wrote:
> On 01/07/2015 01:41 PM, Jason Cooper wrote:

>> One of the reasons I've really enjoyed working with ARM platforms and DT
>> is the absence of this type of 'feature'.  I honestly don't care whether
>> the kernel gets the board configuration info from DT or ACPI or FOO, as
>> long as we can avoid the security mistakes of the past:
>>
>>   http://www.spiegel.de/international/world/catalog-reveals-nsa-has-back-doors-for-numerous-devices-a-940994.html
> 
> ACPI is not the great satan. I'm aware certain others in the community
> have written missinformed blog posts and G+ rants equating ACPI with SMI
> and even with various other system firmware. I can't force someone to
> become informed on a topic, especially if it's politically useful to
> them to hate on ACPI and use the security paranoia handwavy argument.

To clarify, and this is not directed at you Jason, it is politically
useful to some who have written rants those business models are built
upon being paid to enable platforms. For those folks, standardized
platforms which allow a common OS approach are seen as threatening.

In the previous rants (which were really instigated as a result of the
above) ACPI was equated with SMM (System Management Mode), which is a
bit like the Secure/Trusted world on AArch64 in which you might run
another "Trusted" OS. These are the places where you want to watch out
to malware of the kind cited in your link, not in ACPI tables.

Jon.
