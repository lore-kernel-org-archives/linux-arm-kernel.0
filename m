From: ddutile@redhat.com (Don Dutile)
Date: Thu, 05 Feb 2015 13:18:13 -0500
Subject: [PATCH] arm64: Change 'Call trace' to 'Call Trace' for tool
 scanners
In-Reply-To: <20150205173718.GS8656@n2100.arm.linux.org.uk>
References: <1423157427-41997-1-git-send-email-ddutile@redhat.com>
 <20150205173718.GS8656@n2100.arm.linux.org.uk>
Message-ID: <54D3B3E5.4010505@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/05/2015 12:37 PM, Russell King - ARM Linux wrote:
> On Thu, Feb 05, 2015 at 12:30:27PM -0500, Donald Dutile wrote:
>> Receiving reports from service folks that arm64 uses
>> 'Call trace' when dumping stack, instead of the more familiar
>> 'Call Trace'; the former is not being seen by tools that
>> scan for the latter text.  Checking various arches,
>> it appears the mainstream server arches (ia64, mips, ppc,
>> s390, sparc, x86) use 'Call Trace'.
>> This kernel tools script scans for the latter text string as well
>>    tools/testing/selftests/rcutorture/bin/parse-console.sh
>> so it doesn't appear to be arch or vendor specific.
>
> That script should also be changed to accept "Backtrace" which we've had
> for eons on ARM.  I would not be happy to change that given that ARM has
> used "Backtrace" there for a very long time now (not far off 20 years.)
>
So you're saying:
(a) you want 'Backtrace' added to parse-console.sh
(b) 'not happy to change that' .. where 'that' == ?
-dd
