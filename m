From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 11 Feb 2013 10:38:29 +0000
Subject: [PATCH 2/2] ARM: mm: mm->context.id fix for big-endian
In-Reply-To: <20130210232949.GJ17833@n2100.arm.linux.org.uk>
References: <1360508248-25252-1-git-send-email-ben.dooks@codethink.co.uk>
 <1360508248-25252-3-git-send-email-ben.dooks@codethink.co.uk>
 <fbfc1a2851f5dd690ed4d98fc9de3030@codethink.co.uk>
 <20130210232949.GJ17833@n2100.arm.linux.org.uk>
Message-ID: <5118CA25.2020106@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/13 23:29, Russell King - ARM Linux wrote:
> On Sun, Feb 10, 2013 at 03:05:11PM +0000, Ben Dooks wrote:
>> On 10/02/2013 14:57, Ben Dooks wrote:
>>> Since the new ASID code in [b5466f8728527a05a493cc4abe9e6f034a1bbaab]
>>> was changed to use 64bit operations it has broken the BE operation due
>>> to an issue with the MM code accessing sub-fields of mm->context.id.
>>
>> Fixed the ref, new patch pushed to git.
>
> No you haven't.
>
> "Since the new ASID code in b5466f872 (ARM: mm: remove IPI broadcasting
> on ASID rollover)..."
>
> is the correct way to refer to another patch by commit ID - both the ID
> _and_ its summary line.  You can use a short ID but it's a good idea to
> add a few additional characters to avoid future hash clashes.

My repo is showing:

  Since the new ASID code in b5466f8728527a05a493cc4abe9e6f034a1bbaab
  ("ARM: mm: remove IPI broadcasting on ASID rollover") was changed to
  use 64bit operations it has broken the BE operation due to an issue
  with the MM code accessing sub-fields of mm->context.id.

Would you like the commit-id shortened?
Is there anything else before this pair can be pulled?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
