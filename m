From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 24 Oct 2013 23:00:52 -0500
Subject: [RFC PATCH dtc] C-based DT schema checker integrated into dtc
In-Reply-To: <20131024234340.ADF70C403B6@trevor.secretlab.ca>
References: <1382651488-9696-1-git-send-email-swarren@wwwdotorg.org>
 <20131024234340.ADF70C403B6@trevor.secretlab.ca>
Message-ID: <A671CEDF-0999-4F88-BD4C-1C3E6E3360E8@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Oct 24, 2013, at 6:43 PM, Grant Likely wrote:

> On Thu, 24 Oct 2013 22:51:28 +0100, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>> 
>> This is a very quick proof-of-concept re: how a DT schema checker might
>> look if written in C, and integrated into dtc.
> 
> Thanks for looking at this.
> 
> Very interesting. Certainly an expedient way to start checking schemas,
> and for certain bindings it may be the best approach. The downside is it
> forces a recompilation of DTC to bring in new bindings and it isn't a
> great meduim for mixing schema with documentation in the bindings.
> 
> g.

Yeah, I think any solution has to make the Documentation and the schema representation one thing otherwise more error prone and another set of things to review.

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
