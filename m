From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 10 Feb 2013 23:29:50 +0000
Subject: [PATCH 2/2] ARM: mm: mm->context.id fix for big-endian
In-Reply-To: <fbfc1a2851f5dd690ed4d98fc9de3030@codethink.co.uk>
References: <1360508248-25252-1-git-send-email-ben.dooks@codethink.co.uk>
 <1360508248-25252-3-git-send-email-ben.dooks@codethink.co.uk>
 <fbfc1a2851f5dd690ed4d98fc9de3030@codethink.co.uk>
Message-ID: <20130210232949.GJ17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 10, 2013 at 03:05:11PM +0000, Ben Dooks wrote:
> On 10/02/2013 14:57, Ben Dooks wrote:
>> Since the new ASID code in [b5466f8728527a05a493cc4abe9e6f034a1bbaab]
>> was changed to use 64bit operations it has broken the BE operation due
>> to an issue with the MM code accessing sub-fields of mm->context.id.
>
> Fixed the ref, new patch pushed to git.

No you haven't.

"Since the new ASID code in b5466f872 (ARM: mm: remove IPI broadcasting
on ASID rollover)..."

is the correct way to refer to another patch by commit ID - both the ID
_and_ its summary line.  You can use a short ID but it's a good idea to
add a few additional characters to avoid future hash clashes.
