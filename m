From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Wed, 25 Sep 2013 16:52:44 +0100
Subject: new binutils needed for arm in 3.12-rc1
In-Reply-To: <1380122586.1974.84@driftwood> (Rob Landley's message of "Wed, 25
 Sep 2013 10:23:06 -0500")
References: <1380122586.1974.84@driftwood>
Message-ID: <yw1x7ge4x5ir.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Landley <rob@landley.net> writes:

> On 09/24/2013 09:07:57 PM, Nicolas Pitre wrote:
>> I'd strongly suggest you make your binutils compatible with newer
>> instruction syntax instead of making the kernel more complex.
>
> Meaning I play whack-a-mole as this becomes permission to depend on  
> endless new gnuisms just because they're there and nobody else is  
> regression testing against them, not because they actually add anything.

Since when is assembling the instructions correctly, as specified in the
arch ref, and not in some other random way a gnuism?

-- 
M?ns Rullg?rd
mans at mansr.com
