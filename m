From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Mon, 27 Mar 2017 07:44:26 -0600
Subject: [PATCH 0/7] dwc3 - bug fixes and use meaningful goto labels
In-Reply-To: <87poh523r3.fsf@linux.intel.com>
References: <cover.1490387086.git.shuahkh@osg.samsung.com>
 <87poh523r3.fsf@linux.intel.com>
Message-ID: <8477b3ae-7841-db0b-1faa-7c0dfa452082@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/2017 01:51 AM, Felipe Balbi wrote:
> 
> Hi,
> 
> Shuah Khan <shuahkh@osg.samsung.com> writes:
>> This patch series consists of two fixes and changes to goto labels
> 
> we *NEVER* put cleanups and fixes together.
> 
>> to use meaningful names.
>>
>> While working on goto label changes, I noticed  put_sync calls without
>> successful get_sync in error legs.  The first two patches are the fixes
>> and the rest of the patches are goto label changes.
> 
> so, you mean to say that you're adding regressions because you *THOUGHT*
> there was a bug there, right? Read the docs ;-)
> 

Sorry for the noise. Thanks for pointing this out.

-- Shuah
