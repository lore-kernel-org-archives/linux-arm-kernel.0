From: jcm@redhat.com (Jon Masters)
Date: Wed, 02 May 2012 13:37:45 -0400
Subject: [PATCH] ARM: Fix restoration of IP scratch register when auditing
 syscalls
In-Reply-To: <20120502153933.GD547@mudshark.cambridge.arm.com>
References: <1335681504-4609-1-git-send-email-jcm@jonmasters.org>
 <1335681504-4609-2-git-send-email-jcm@jonmasters.org>
 <20120430100746.GA11080@mudshark.cambridge.arm.com>
 <4F9EE024.8000906@redhat.com>
 <20120501110744.GD2305@mudshark.cambridge.arm.com>
 <4FA0D3CA.8080704@jonmasters.org>
 <20120502085828.GB547@mudshark.cambridge.arm.com>
 <42BD0A3B-1820-4C51-8303-A73A6AB974B8@jonmasters.org>
 <1335970090.30722.13.camel@localhost>
 <20120502153933.GD547@mudshark.cambridge.arm.com>
Message-ID: <4FA170E9.6090908@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/02/2012 11:39 AM, Will Deacon wrote:
> On Wed, May 02, 2012 at 03:48:10PM +0100, Eric Paris wrote:

>> I'm fine with not supporting things.  But I'm pretty stupid here.  Is
>> this just not supporting some old chip?  Or is this some ABI that a new
>> chip could have both and can switch at run time?  If the latter, we need
>> to support it.  If the former, and hints on how to make sure you can't
>> build audit with OABI?
> 
> My current hack in the kernel is to change the Kconfig entries for audit. As
> for userspace, I guess you have to check the toolchain triplet somehow. v6
> onwards makes use only of EABI and it's becoming increasingly more difficult
> to find distributions supporting OABI (required for CPUs prior to v4t).

I'll followup with an email explaining ARM ABIs to help out - might take
me a bit of time to get to it.

Jon.
