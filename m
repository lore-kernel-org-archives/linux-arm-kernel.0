From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Sun, 10 Feb 2013 15:05:11 +0000
Subject: [PATCH 2/2] ARM: mm: mm->context.id fix for big-endian
In-Reply-To: <1360508248-25252-3-git-send-email-ben.dooks@codethink.co.uk>
References: <1360508248-25252-1-git-send-email-ben.dooks@codethink.co.uk>
 <1360508248-25252-3-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <fbfc1a2851f5dd690ed4d98fc9de3030@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/2013 14:57, Ben Dooks wrote:
> Since the new ASID code in [b5466f8728527a05a493cc4abe9e6f034a1bbaab]
> was changed to use 64bit operations it has broken the BE operation 
> due
> to an issue with the MM code accessing sub-fields of mm->context.id.

Fixed the ref, new patch pushed to git.
