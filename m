From: james.hogan@imgtec.com (James Hogan)
Date: Fri, 10 May 2013 11:43:53 +0100
Subject: [PATCH v2 0/3] clk: implement remuxing during set_rate
In-Reply-To: <518BFD99.2010208@codeaurora.org>
References: <1366388904-13903-1-git-send-email-james.hogan@imgtec.com>
 <518AE16D.5060501@codeaurora.org> <518B663D.60806@imgtec.com>
 <518BFD99.2010208@codeaurora.org>
Message-ID: <518CCF69.9040200@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/13 20:48, Stephen Boyd wrote:
> On 05/09/13 02:02, James Hogan wrote:
>> On 09/05/13 00:36, Stephen Boyd wrote:
>>> Which tree is this based on? I get failures with git am on patch 2.
>>>
>> It was based on v3.9-rc4.
>>
> 
> Thanks. Would it be possible for you to update to Mike's for-next
> branch? I've done the rebase myself for now and it seems to work well
> enough. I'll need to add the set_rate_and_parent() op on top.
> 

Yes, I will do that before reposting. Thanks for giving it a spin.

Cheers
James
